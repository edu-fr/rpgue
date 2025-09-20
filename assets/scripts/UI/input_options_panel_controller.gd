class_name InputOptionsPanelController
extends Control

enum BUTTON { UNKNOWN, NONE, ATTACK }
@export var _attackButton: Button

var _stateMachine: BattleStateMachine


func init(battleStateMachine: BattleStateMachine) -> void:
	_stateMachine = battleStateMachine

	_attackButton.pressed.connect(_stateMachine.on_attack_clicked)
	_attackButton.focus_mode = Control.FOCUS_ALL

	hide_and_disable() # buttons start disabled

	return


func show_and_enable() -> void:
	show()
	_set_buttons_enabled(true)

	return


func hide_and_disable() -> void:
	hide()
	_set_buttons_enabled(false)

	return


func _set_buttons_enabled(value: bool) -> void:
	_attackButton.disabled = !value

	if (value == true):
		_attackButton.grab_focus()
	else:
		_attackButton.release_focus()

	return
