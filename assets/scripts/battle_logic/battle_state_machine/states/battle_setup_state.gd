class_name BattleSetupState
extends BaseBattleState

func on_state_start() -> void:
	stateMachine.battleScene.setup_scene()
	stateMachine.swap_state(IdlePlayerBattleState.new(stateMachine))

	return
