class_name BattleSetupState
extends BaseBattleState

func on_state_start() -> void:
	_stateMachine.battleScene.setup_scene()
	_stateMachine.swap_state(_get_next_actor_turn())

	return
