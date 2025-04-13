class_name PlayerAttackResultState
extends BaseBattleState

func on_state_start() -> void:

	return


func on_confirm_clicked() -> void:
	print("Player attack result battle state confirm clicked")
	stateMachine.swap_state(CheckBattleState.new(stateMachine, EnemyTurnStartState.new(stateMachine)))

	return


func on_attack_clicked() -> void:
	print("Player attack result battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("Player attack result battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("Player attack result battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("Player attack result battle state tech index " + str(index) + " clicked")

	return
