class_name BattleWinState
extends BaseBattleState


var _playerBattleActor: PlayerBattleActor

func _init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor

	return


func on_state_start() -> void:
	# Show final animation
	print("Battle won")
	GM.runManager.currentRunDataRef.on_level_beated(_playerBattleActor)
	GM.flowManager.open_upgrade_scene()

	return
