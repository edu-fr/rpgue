class_name InputOptionsPanelController
extends Control

enum BUTTON { UNKNOWN, NONE, ATTACK }
@export var _attackButton: Button

var _remainingEnemiesRef: Array[EnemyController]
signal playerTurn(turnResult: PlayerAction)
var _stateMachine: BattleStateMachine


func init(battleStateMachine: BattleStateMachine) -> void:
	_stateMachine = battleStateMachine

	_attackButton.pressed.connect(_on_attack_button_pressed)
	_attackButton.focus_mode = Control.FOCUS_ALL

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


func set_buttons_enabled(value: bool) -> void:
	_attackButton.disabled = !value

	if (value == true):
		_attackButton.grab_focus()
	else:
		_attackButton.release_focus()

	return

	#endregion
