class_name CheckBattleState
extends BaseBattleState

var _nextState: BaseBattleState


func _init(battleStateMachine: BattleStateMachine, nextState: BaseBattleState) -> void:
	super(battleStateMachine)
	_nextState = nextState

	return


func on_state_start() -> void:
	var battle_result: BattleScene.BattleResult = stateMachine.battleScene.get_battle_result()
	match(battle_result):
		BattleScene.BattleResult.ONGOING:
			stateMachine.swap_state(_nextState)
		BattleScene.BattleResult.PLAYER_WIN:
			stateMachine.pop_stack(BattleWinState.new(stateMachine))
		BattleScene.BattleResult.ONGOING:
			stateMachine.pop_stack(BattleLossState.new(stateMachine))

	return
