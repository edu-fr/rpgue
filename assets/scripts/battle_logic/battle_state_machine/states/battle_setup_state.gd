class_name BattleSetupState extends BaseBattleState


func on_state_start() -> void:
	stateMachine.battleScene.setup_scene()
	
	return
