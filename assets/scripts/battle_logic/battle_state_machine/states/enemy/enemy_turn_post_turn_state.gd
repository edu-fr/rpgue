class_name EnemyTurnPostTurnState
extends BaseBattleState

var _enemyInstance: EnemyBattleActor


func _init(enemyInstance: EnemyBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_enemyInstance = enemyInstance

	return


func on_state_start() -> void:
	_enemyInstance.activate_post_turn_start_effects()

	if (_check_battle_ended()):
		return

	if (skipping_turn_as_enemy_is_not_alive(_enemyInstance)):
		return

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, _get_next_actor_turn()))

	return
