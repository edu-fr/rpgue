class_name PlayerAttackResultState
extends BaseBattleState

var _battleMove: BattleMove
var _targetEnemiesIds: Array[int]


func _init(battleMove: BattleMove, targetEnemiesIndexes: Array[int], stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_battleMove = battleMove
	_targetEnemiesIds = targetEnemiesIndexes

	return


func on_state_start() -> void:
	print("MOVE USED: " + _battleMove.publicName + \
		"; Should do " + str(_battleMove.getMoveData().baseDamage) + " damage.")

	for _enemyIndex: int in _targetEnemiesIds:
		var _enemy: EnemyController = _stateMachine.battleScene._get_remaining_enemy_by_id(_enemyIndex)
		_enemy.receive_player_attack(_battleMove.getMoveData().baseDamage)

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, EnemyTurnStartState.new(_stateMachine)))

	return