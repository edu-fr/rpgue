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
	if (GM.verbose):
		print("[PLAYER ATTACK RESULT STATE] Move used:")
		print(_battleMove)

	for _enemyIndex: int in _targetEnemiesIds:
		var _enemy: EnemyController = _stateMachine.battleScene._get_remaining_enemy_by_id(_enemyIndex)
		assert(_enemy != null, "Player attack result state could find a enemy with index " + str(_enemyIndex))
		_enemy.receive_player_attack(_battleMove.get_use_result(_enemy.get_battle_actor()))

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, PlayerTurnPostTurnState.new(_playerBattleActor, _stateMachine)))

	return