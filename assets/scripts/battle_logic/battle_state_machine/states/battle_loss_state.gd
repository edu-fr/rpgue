class_name BattleLossState
extends BaseBattleState

func on_state_start() -> void:
	print("Battle loss")
	GM.flowManager.go_to_main_menu()

	return