class_name ActionsPanelController

extends Control

enum BUTTON {NONE, ATTACK, MAGIC, DEFEND}

@export var _attackButton: Button
@export var _magicButton: Button
@export var _defendButton: Button

var _enemiesRef: Array[EnemyController]
signal playerTurn(turnResult: PlayerTurnResult)

func init(enemiesRef: Array[EnemyController]) -> void:
	_enemiesRef = enemiesRef

	_attackButton.pressed.connect(_on_attack_button_pressed)
	_magicButton.pressed.connect(_on_magic_button_pressed)
	_defendButton.pressed.connect(_on_defend_button_pressed)

	_set_buttons_enabled(false) # buttons start disabled

	return

func start_turn() -> PlayerTurnResult:
	self.show()
	_set_buttons_enabled(true)

	return await playerTurn

#region Button Selection

func _on_attack_button_pressed() -> void:
	_open_enemy_selection(BUTTON.ATTACK) 

	return

func _on_magic_button_pressed() -> void:
	_open_enemy_selection(BUTTON.MAGIC)

	return

func _on_defend_button_pressed() -> void:
	playerTurn.emit(PlayerTurnResult.new(_buttonPressedToPlayerActionType(BUTTON.DEFEND), -1))

	return

func _set_buttons_enabled(value: bool) -> void:
	var focusMode = Control.FOCUS_ALL if value else Control.FOCUS_NONE

	_attackButton.disabled = !value
	_attackButton.focus_mode = focusMode

	if (value):
		_attackButton.grab_focus()

	_magicButton.disabled = !value
	_magicButton.focus_mode = focusMode

	_defendButton.disabled = !value
	_defendButton.focus_mode = focusMode

	return

func _buttonPressedToPlayerActionType(button: BUTTON) -> PlayerTurnResult.ActionCategory:
	match button:
		BUTTON.ATTACK:
			return PlayerTurnResult.ActionCategory.ATTACK
		BUTTON.MAGIC:
			return PlayerTurnResult.ActionCategory.MAGIC
		BUTTON.DEFEND:
			return PlayerTurnResult.ActionCategory.DEFEND
		BUTTON.NONE:
			push_error("Retornando acao de player sem ter botao escolhido definido")
			return PlayerTurnResult.ActionCategory.NONE

	push_error("Tipo de botao pressionado na acao do player nao existente")
	return PlayerTurnResult.ActionCategory.NONE

#endregion

#region Enemy Targeting

var _hoveredEnemy: int
var _currentButtonPressed: BUTTON

func _open_enemy_selection(buttonType: BUTTON) -> void:
	_set_buttons_enabled(false) # button clicks must be disabled during enemy selection
	_currentButtonPressed = buttonType
	_hover_first_enemy()

	return


func _input(_event: InputEvent) -> void:
	if (_currentButtonPressed == BUTTON.ATTACK or _currentButtonPressed == BUTTON.MAGIC):
		_input_select_target()

	return

func _input_select_target() -> void:
	if (Input.is_action_just_released("ui_accept")):
		_select_current_targeted_enemy()
		_cancel_enemy_selection()

	elif (Input.is_action_just_released("ui_cancel")):
		_cancel_enemy_selection()

	elif (Input.is_action_just_released("ui_right")):
		_hover_next_enemy()

	elif (Input.is_action_just_released("ui_left")):
		_hover_previous_enemy()

	return

func _hover_first_enemy() -> void:
	_hoveredEnemy = 0
	_on_hover_changed()
	return

func _select_current_targeted_enemy() -> void:
	playerTurn.emit(PlayerTurnResult.new(_buttonPressedToPlayerActionType(_currentButtonPressed), _hoveredEnemy))
	return

func _hover_next_enemy() -> void:
	_hoveredEnemy = (_hoveredEnemy + 1) if _hoveredEnemy < _enemiesRef.size() - 1 else 0
	_on_hover_changed()
	return

func _hover_previous_enemy() -> void:
	_hoveredEnemy = (_hoveredEnemy - 1) if _hoveredEnemy > 0 else _enemiesRef.size() - 1
	_on_hover_changed()
	return

func _on_hover_changed() -> void:
	for i in _enemiesRef.size():
		_enemiesRef[i].set_selected(i == _hoveredEnemy)
	return

func _cancel_enemy_selection() -> void:
	_hoveredEnemy = -1
	_on_hover_changed()

	_currentButtonPressed = BUTTON.NONE
	_set_buttons_enabled(true)

	return

#endregion
