class_name IdlePlayerBattleState
extends BaseBattleState

func on_confirm_clicked() -> void:
	print("Idle player battle state confirm clicked")

	return


func on_attack_clicked() -> void:
	print("Idle player battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("Idle player battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("Idle player battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("Idle player battle state tech index " + str(index) + " clicked")

	return
