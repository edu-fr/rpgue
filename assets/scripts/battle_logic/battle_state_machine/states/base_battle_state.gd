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


func _check_battle_ended() -> bool:
	var _battle_result: BattleEnums.BattleResult = _stateMachine.battleScene.get_battle_result()
	match(_battle_result):
		BattleEnums.BattleResult.ONGOING:
			return false
		BattleEnums.BattleResult.PLAYER_WIN:
			_stateMachine.pop_stack(BattleWinState.new(_stateMachine))
			return true
		BattleEnums.BattleResult.PLAYER_LOSE:
			_stateMachine.pop_stack(BattleLossState.new(_stateMachine))
			return true
		BattleEnums.BattleResult.UNKNOWN:
			push_error("Unexpected battle result")
			return true

	push_error("Unexpected battle result")
	return true


func _get_next_actor_turn() -> BaseBattleState:
	var _nextTurnOwnerId: int = _stateMachine.battleScene.get_next_turn_owner_id()
	if (_nextTurnOwnerId < 10):
		var _enemyController: EnemyController = _stateMachine.battleScene.get_enemy_controller_by_id(_nextTurnOwnerId)
		return EnemyPreTurnState.new(_enemyController.get_instance(), _stateMachine)
	else:
		var _playerInstance: PlayerInstance = _stateMachine.battleScene.get_player_instance()
		return PlayerPreTurnState.new(_playerInstance, _stateMachine)

	return null