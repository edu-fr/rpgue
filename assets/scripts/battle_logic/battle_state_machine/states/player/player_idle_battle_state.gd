class_name PlayerIdleBattleState
extends BaseBattleState

func on_state_start() -> void:
	var playerController: PlayerBattleUIController = stateMachine.battleScene._playerController
	playerController.show_and_enable_actions_panel()


func on_confirm_clicked() -> void:
	print("player Idle battle state confirm clicked")
	stateMachine.push_state(PlayerSelectMoveState.new(stateMachine))

	return


func on_attack_clicked() -> void:
	print("player Idle battle state attack clicked")
	stateMachine.push_state(PlayerSelectMoveState.new(stateMachine))

	return


func on_tech_clicked() -> void:
	print("player Idle battle state tech clicked")
	stateMachine.push_state(PlayerSelectMoveState.new(stateMachine))

	return


func on_attack_index_cliked(index: int) -> void:
	print("player Idle battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("player Idle battle state tech index " + str(index) + " clicked")

	return


func on_back_clicked() -> void:
	print("player Idle battle state back clicked")

	return