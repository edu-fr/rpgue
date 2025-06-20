class_name EnemyTurnPostTurnState
extends BaseBattleState

var _enemyInstance: EnemyInstance


func _init(enemyInstance: EnemyInstance, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_enemyInstance = enemyInstance

	return


func on_state_start() -> void:
	_enemyInstance.activate_post_turn_start_effects()

	if (_check_battle_ended()):
		return

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, _get_next_actor_turn()))

	return
