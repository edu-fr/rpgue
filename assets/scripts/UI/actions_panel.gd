class_name ActionsPanelController
extends Control

enum BUTTON {NONE, ATTACK, MAGIC, DEFEND}
@export var _attackButton: Button
@export var _magicButton: Button
@export var _defendButton: Button

var _remainingEnemiesRef: Array[EnemyController]
signal playerTurn(turnResult: PlayerAction)


func init() -> void:
	_attackButton.pressed.connect(_on_attack_button_pressed)
	_magicButton.pressed.connect(_on_magic_button_pressed)
	_defendButton.pressed.connect(_on_defend_button_pressed)

	_attackButton.focus_mode = Control.FOCUS_ALL
	_magicButton.focus_mode = Control.FOCUS_ALL
	_defendButton.focus_mode = Control.FOCUS_ALL

	_set_buttons_enabled(false) # buttons start disabled

	return


func start_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	_remainingEnemiesRef = remainingEnemies
	_set_buttons_enabled(true)

	self.show()
	var playerAction: PlayerAction = await playerTurn
	_set_buttons_enabled(false)

	return playerAction


#region Button Selection

func _on_attack_button_pressed() -> void:
	_open_enemy_selection(BUTTON.ATTACK)

	return


func _on_magic_button_pressed() -> void:
	_open_enemy_selection(BUTTON.MAGIC, true)

	return


func _on_defend_button_pressed() -> void:
	playerTurn.emit(PlayerAction.new(_buttonPressedToPlayerActionType(BUTTON.DEFEND), []))

	return


func _set_buttons_enabled(value: bool) -> void:
	print("Setting buttons enabled: " + str(value))
	_defendButton.disabled = !value
	_attackButton.disabled = !value
	_magicButton.disabled = !value

	if (value == true):
		_attackButton.grab_focus()
	else:
		_attackButton.release_focus()
		_magicButton.release_focus()
		_defendButton.release_focus()

	return


func _buttonPressedToPlayerActionType(button: BUTTON) -> PlayerAction.ActionCategory:
	match button:
		BUTTON.ATTACK:
			return PlayerAction.ActionCategory.ATTACK
		BUTTON.MAGIC:
			return PlayerAction.ActionCategory.MAGIC
		BUTTON.DEFEND:
			return PlayerAction.ActionCategory.DEFEND
		BUTTON.NONE:
			push_error("Retornando acao de player sem ter botao escolhido definido")
			return PlayerAction.ActionCategory.NONE

	push_error("Tipo de botao pressionado na acao do player nao existente")

	return PlayerAction.ActionCategory.NONE

#endregion


#region Enemy Targeting

var _hoveredEnemies: Array[int]
var _currentButtonPressed: BUTTON
var _selecting: bool


func _open_enemy_selection(buttonType: BUTTON, all: bool = false) -> void:
	_set_buttons_enabled(false) # button clicks must be disabled during enemy selection
	_currentButtonPressed = buttonType

	if (all):
		_hover_all()
	else:
		_hover_first_enemy()

	_selecting = true;

	return


func _unhandled_input(_event: InputEvent) -> void:
	if (!_selecting):
		return

	if (_currentButtonPressed == BUTTON.ATTACK or _currentButtonPressed == BUTTON.MAGIC):
		_input_select_target(_event)

	return


func _input_select_target(_event: InputEvent) -> void:
	if (_event.is_action_pressed("ui_accept")):
		var _selectedEnemiesIds: Array[int] = _get_current_targeted_enemies_ids()
		var _buttonPressed: BUTTON = _currentButtonPressed
		_cancel_enemy_selection()
		playerTurn.emit(PlayerAction.new(_buttonPressedToPlayerActionType(_buttonPressed), _selectedEnemiesIds))

	elif (_event.is_action_pressed("ui_cancel")):
		_cancel_enemy_selection()
		_set_buttons_enabled(true)

	elif (_event.is_action_pressed("ui_right")):
		_hover_next_enemy()

	elif (_event.is_action_pressed("ui_left")):
		_hover_previous_enemy()

	return


func _hover_first_enemy() -> void:
	_hoveredEnemies = [0]
	_on_hover_changed()
	return


func _get_current_targeted_enemies_ids() -> Array[int]:
	var array: Array = _hoveredEnemies.map(func(enemyIndex: int) -> int: return _remainingEnemiesRef[enemyIndex].enemy_id)
	var hoveredEnemiesIds: Array[int] = []
	hoveredEnemiesIds.assign(array)

	return hoveredEnemiesIds


func _hover_next_enemy() -> void:
	var _last: int = _hoveredEnemies.back()
	_hoveredEnemies.remove_at(0)
	var _newIndex: int = _last + 1 if _last < (_remainingEnemiesRef.size() - 1) else 0
	_hoveredEnemies.append(_newIndex)

	_on_hover_changed()
	return


func _hover_previous_enemy() -> void:
	var _first: int = _hoveredEnemies.front()
	_hoveredEnemies.remove_at(_hoveredEnemies.size() - 1)
	var _newIndex: int = _first - 1 if _first > 0 else (_remainingEnemiesRef.size() - 1)
	_hoveredEnemies.append(_newIndex)

	_on_hover_changed()
	return


func _hover_all() -> void:
	_hoveredEnemies.clear()
	for i: int in range(_remainingEnemiesRef.size()):
		_hoveredEnemies.append(i)
	_on_hover_changed()

	return


func _on_hover_changed() -> void:
	for i: int in _remainingEnemiesRef.size():
		_remainingEnemiesRef[i].set_selected(_hoveredEnemies.find(i) != -1)
	return


func _cancel_enemy_selection() -> void:
	_hoveredEnemies = []
	_on_hover_changed()

	_currentButtonPressed = BUTTON.NONE
	_selecting = false

	return

	#endregion
