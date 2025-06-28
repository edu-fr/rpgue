class_name EnemyPreTurnState
extends BaseBattleState

var _enemyInstance: EnemyBattleActor
var _moveToUse: BattleMove


func _init(enemyInstance: EnemyBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_enemyInstance = enemyInstance

	return


func on_state_start() -> void:
	_enemyInstance.activate_pre_turn_start_effects()

	if (_change_state_if_battle_ended()):
		return

	if (skipping_turn_as_enemy_is_not_alive(_enemyInstance)):
		return

	_moveToUse = _enemyInstance.get_random_move()

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, EnemyTurnActionState.new(_moveToUse, _enemyInstance, _stateMachine)))

	return
