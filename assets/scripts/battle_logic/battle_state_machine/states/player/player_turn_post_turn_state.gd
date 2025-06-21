class_name PlayerTurnPostTurnState
extends BaseBattleState

var _playerBattleActor: PlayerBattleActor

func _init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor

	return


func on_state_start() -> void:
	_playerBattleActor.activate_post_turn_start_effects()

	if (_check_battle_ended()):
		return

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, _get_next_actor_turn()))

	return
