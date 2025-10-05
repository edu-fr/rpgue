class_name ChangeTurnState
extends BaseBattleState


func _init(battleStateMachine: BattleStateMachine) -> void:
	super(battleStateMachine)

	return


func on_state_start() -> void:
	if (_change_state_if_battle_ended()):
		return

	_stateMachine.swap_state(_get_next_actor_turn())

	return
