class_name PlayerTurnPostTurnState
extends BaseBattleState

var _playerInstance: PlayerInstance

func _init(playerInstance: PlayerInstance, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerInstance = playerInstance

	return


func on_state_start() -> void:
	_playerInstance.activate_post_turn_start_effects()

	if (_check_battle_ended()):
		return

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, _get_next_actor_turn()))

	return
