class_name PlayerAttackResultState
extends BaseBattleState

var _selectedBattleMoves: Array[SelectedBattleMove]
var _playerBattleActor: PlayerBattleActor


func _init(selectedBattleMoves: Array[SelectedBattleMove], playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor
	_selectedBattleMoves = selectedBattleMoves

	return


func on_state_start() -> void:
	if (GM.verbose):
		print("[PLAYER ATTACK RESULT STATE] Moves used:")
		for move: SelectedBattleMove in _selectedBattleMoves:
			print(move)

	for move: SelectedBattleMove in _selectedBattleMoves:
		for _enemyIndex: int in move.targetEnemiesIds:
			var _enemy: EnemyController = _stateMachine.battleScene._get_remaining_enemy_by_id_or_null(_enemyIndex)
			if (_enemy == null):
				continue

			_enemy.receive_player_attack(move.battleMove.get_use_result(_enemy.get_battle_actor()))

			# wait for animations
			await _stateMachine.battleScene.get_tree().create_timer(.7).timeout

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, PlayerTurnPostTurnState.new(_playerBattleActor, _stateMachine)))

	return



