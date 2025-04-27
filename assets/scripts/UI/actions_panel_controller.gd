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

	#endregion
