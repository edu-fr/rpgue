class_name BaseBattleState
extends BaseState

var _stateMachine: BattleStateMachine


func _init(stateMachine: BattleStateMachine) -> void:
	_stateMachine = stateMachine

	return


func on_attack_clicked() -> void:
	print("Base battle attack clicked")

	return


func on_tech_clicked() -> void:
	print("Base battle tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("Base battle attack " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("Base battle tech " + str(index) + " clicked")

	return


func _change_state_if_battle_ended() -> bool:
	var _battleResult: BattleEnums.BattleResult = _stateMachine.battleScene.get_battle_result()
	var _player: PlayerBattleActor = _stateMachine.battleScene.get_player()
	match(_battleResult):
		BattleEnums.BattleResult.ONGOING:
			return false
		BattleEnums.BattleResult.PLAYER_WIN:
			_stateMachine.pop_stack(BattleWinState.new(_player, _stateMachine))
			return true
		BattleEnums.BattleResult.PLAYER_LOSE:
			_stateMachine.pop_stack(BattleLossState.new(_stateMachine))
			return true
		BattleEnums.BattleResult.UNKNOWN:
			push_error("Unexpected battle result")
			return true

	push_error("Unexpected battle result")
	return true


func skipping_turn_as_enemy_is_not_alive(enemyInstance: EnemyBattleActor) -> bool:
	if (enemyInstance.alive()):
		return false

	_stateMachine.swap_state(_get_next_actor_turn())

	return true


func _get_next_actor_turn() -> BaseBattleState:
	var _nextTurnOwnerId: int = _stateMachine.battleScene.get_next_turn_owner_id()

	if (_nextTurnOwnerId < _stateMachine.battleScene.enemyLimit):
		var _enemyController: EnemyController = _stateMachine.battleScene.get_enemy_controller_by_id(_nextTurnOwnerId)
		return EnemyPreTurnState.new(_enemyController.get_battle_actor(), _stateMachine)
	else:
		var _playerBattleActor: PlayerBattleActor = _stateMachine.battleScene.get_player()
		return PlayerPreTurnState.new(_playerBattleActor, _stateMachine)