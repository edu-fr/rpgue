class_name CheckBattleState
extends BaseBattleState

var _nextState: BaseBattleState


func _init(battleStateMachine: BattleStateMachine, nextState: BaseBattleState) -> void:
	super(battleStateMachine)
	_nextState = nextState

	return


func on_state_start() -> void:
	var battle_result: BattleScene.BattleResult = _stateMachine.battleScene.get_battle_result()
	match(battle_result):
		BattleScene.BattleResult.ONGOING:
			_stateMachine.swap_state(_nextState)
		BattleScene.BattleResult.PLAYER_WIN:
			_stateMachine.pop_stack(BattleWinState.new(_stateMachine))
		BattleScene.BattleResult.ONGOING:
			_stateMachine.pop_stack(BattleLossState.new(_stateMachine))

	return
