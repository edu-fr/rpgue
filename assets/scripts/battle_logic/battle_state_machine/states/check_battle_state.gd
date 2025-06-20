class_name CheckBattleState
extends BaseBattleState

var _nextState: BaseBattleState


func _init(battleStateMachine: BattleStateMachine, nextState: BaseBattleState) -> void:
	super(battleStateMachine)
	_nextState = nextState

	return


func on_state_start() -> void:
	if (_check_battle_ended()):
		var _battleResult: BattleEnums.BattleResult = _stateMachine.battleScene.get_battle_result()
		if (GM.verbose):
			print("Battle ended with result: " + str(_battleResult) + ". Base battle state machine will now transition to the end state. ")

		if (_battleResult == BattleEnums.BattleResult.PLAYER_WIN):
			_stateMachine.pop_stack(BattleWinState.new(_stateMachine))
		else:
			_stateMachine.pop_stack(BattleLossState.new(_stateMachine))

		return

	_stateMachine.swap_state(_nextState)

	return
