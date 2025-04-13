class_name PlayerSelectMoveState
extends BaseBattleState

func on_state_start() -> void:

	return


func on_confirm_clicked() -> void:
	print("player select move battle state confirm clicked")

	return


func on_attack_clicked() -> void:
	print("player select move battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("player select move battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("player select move battle state attack index " + str(index) + " clicked")
	stateMachine.push_state(PlayerSelectTargetState.new(stateMachine))

	return


func on_tech_index_cliked(index: int) -> void:
	print("player select move battle state tech index " + str(index) + " clicked")
	stateMachine.push_state(PlayerSelectTargetState.new(stateMachine))

	return


func on_back_clicked() -> void:
	print("player select move battle state back clicked")
	stateMachine.pop_state()

	return