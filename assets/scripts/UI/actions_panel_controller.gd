class_name ActionsPanelController
extends Control

enum BUTTON {NONE, ATTACK, TECH}
@export var _attackButton: Button
@export var _techButton: Button

var _remainingEnemiesRef: Array[EnemyController]
signal playerTurn(turnResult: PlayerAction)
var _stateMachine: BattleStateMachine


func init(battleStateMachine: BattleStateMachine) -> void:
	_stateMachine = battleStateMachine

	_attackButton.pressed.connect(_on_attack_button_pressed)
	_techButton.pressed.connect(_on_tech_button_pressed)

	_attackButton.focus_mode = Control.FOCUS_ALL
	_techButton.focus_mode = Control.FOCUS_ALL

	set_buttons_enabled(false) # buttons start disabled

	return


func start_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	_remainingEnemiesRef = remainingEnemies
	set_buttons_enabled(true)

	self.show()
	var playerAction: PlayerAction = await playerTurn
	set_buttons_enabled(false)

	return playerAction


#region Button Selection

func _on_attack_button_pressed() -> void:
	_stateMachine.on_attack_clicked()

	return


func _on_tech_button_pressed() -> void:
	_stateMachine.on_tech_clicked()

	return


func set_buttons_enabled(value: bool) -> void:
	print("Setting buttons enabled: " + str(value))
	_attackButton.disabled = !value
	_techButton.disabled = !value

	if (value == true):
		_attackButton.grab_focus()
	else:
		_attackButton.release_focus()
		_techButton.release_focus()

	return


func _buttonPressedToPlayerActionType(button: BUTTON) -> PlayerAction.ActionCategory:
	match button:
		BUTTON.ATTACK:
			return PlayerAction.ActionCategory.ATTACK
		BUTTON.TECH:
			return PlayerAction.ActionCategory.TECH
		BUTTON.NONE:
			push_error("Retornando acao de player sem ter botao escolhido definido")
			return PlayerAction.ActionCategory.NONE

	push_error("Tipo de botao pressionado na acao do player nao existente")

	return PlayerAction.ActionCategory.NONE


#endregion

func _open_move_selection(buttonType: BUTTON) -> void:
	match buttonType:
		BUTTON.ATTACK:
			_show_player_attacks()
			pass
		BUTTON.TECH:
			_show_player_techs()
			pass
		BUTTON.NONE:
			push_error("Trying to open attack selection with the wrong button type")

	return


func _show_player_attacks() -> void:
	print("Showing player attacks")
	return


func _show_player_techs() -> void:
	print("Showing player techs")
	return
	