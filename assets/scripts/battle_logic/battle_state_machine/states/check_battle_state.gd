class_name CheckBattleState
extends BaseBattleState

var _nextState: BaseBattleState


func _init(battleStateMachine: BattleStateMachine, nextState: BaseBattleState) -> void:
	super(battleStateMachine)
	_nextState = nextState

	return


func on_state_start() -> void:
	var result: BattleScene.BattleResult = _check_battle_ended()
	if (result == BattleScene.BattleResult.ONGOING):
		_stateMachine.swap_state(_nextState)
	else:
		print("Battle ended with result: " + str(result) + ". Base battle state machine will now transition to the end state. ")

	return
