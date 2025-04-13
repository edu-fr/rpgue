class_name BattleWinState
extends BaseBattleState

func on_state_start() -> void:
	# Show final animation
	print("Battle won")
	GM.flowManager.open_upgrade_scene()

	return
