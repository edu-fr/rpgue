class_name BaseBattleState
extends BaseState

var _stateMachine: BattleStateMachine


func _init(machine: BattleStateMachine) -> void:
	_stateMachine = machine

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
	var battle_result: BattleScene.BattleResult = _stateMachine.battleScene.get_battle_result()
	match(battle_result):
		BattleScene.BattleResult.ONGOING:
			return false
		BattleScene.BattleResult.PLAYER_WIN:
			_stateMachine.pop_stack(BattleWinState.new(_stateMachine))
			return true
		BattleScene.BattleResult.ONGOING:
			_stateMachine.pop_stack(BattleLossState.new(_stateMachine))
			return true

	push_error("Unexpected battle result. Ending battle")
	return true
