class_name EnemyTurnEndState
extends BaseBattleState

func on_state_start() -> void:

	return


func on_confirm_clicked() -> void:
	print("enemy turn end battle state confirm clicked")
	stateMachine.swap_state(CheckBattleState.new(stateMachine, PlayerIdleBattleState.new(stateMachine)))

	return


func on_attack_clicked() -> void:
	print("enemy turn end battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("enemy turn end battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("enemy turn end battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("enemy turn end battle state tech index " + str(index) + " clicked")

	return
