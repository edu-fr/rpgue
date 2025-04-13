class_name PlayerSelectTargetState
extends BaseBattleState

func on_state_start() -> void:

	return


func on_confirm_clicked() -> void:
	print("player select target battle state confirm clicked")
	stateMachine.pop_stack(PlayerAttackResultState.new(stateMachine))

	return


func on_attack_clicked() -> void:
	print("player select target battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("player select target battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("player select target battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("player select target battle state tech index " + str(index) + " clicked")

	return
