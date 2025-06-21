class_name PlayerAttackResultState
extends BaseBattleState

var _battleMove: BattleMove
var _targetEnemiesIds: Array[int]
var _playerBattleActor: PlayerBattleActor


func _init(battleMove: BattleMove, targetEnemiesIndexes: Array[int], playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor
	_battleMove = battleMove
	_targetEnemiesIds = targetEnemiesIndexes

	return


func on_state_start() -> void:
	print("MOVE USED: " + _battleMove.publicName + "; Should do " + str(_battleMove.get_move_data().baseDamage) + " damage.")

	for _enemyIndex: int in _targetEnemiesIds:
		var _enemy: EnemyController = _stateMachine.battleScene._get_remaining_enemy_by_id(_enemyIndex)
		_enemy.receive_player_attack(_battleMove.get_move_data())

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, PlayerTurnPostTurnState.new(_playerBattleActor, _stateMachine)))

	return