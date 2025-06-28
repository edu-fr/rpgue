class_name CheckBattleState
extends BaseBattleState

var _nextState: BaseBattleState


func _init(battleStateMachine: BattleStateMachine, nextState: BaseBattleState) -> void:
	super(battleStateMachine)
	_nextState = nextState

	return


func on_state_start() -> void:
	if (_change_state_if_battle_ended()):
		return

	_stateMachine.swap_state(_nextState)

	return
