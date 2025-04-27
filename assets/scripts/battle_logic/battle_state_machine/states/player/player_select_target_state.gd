class_name PlayerSelectTargetState
extends BaseBattleState

var _battleMove: BattleMove
var _enemyTargetingController: EnemyTargetingController


func _init(battleMove: BattleMove, battleStateMachine: BattleStateMachine) -> void:
	super(battleStateMachine)

	_battleMove = battleMove
	var enemiesRef: Array[EnemyController] = _stateMachine.battleScene._get_remaining_enemies()
	_enemyTargetingController = EnemyTargetingController.new(_battleMove, enemiesRef)

	return


func on_state_start() -> void:
	var _moveTargets: Array[MoveData.MoveTarget] = _battleMove.getMoveData().targets
	if (_moveTargets.has(MoveData.MoveTarget.SELF) or _moveTargets.has(MoveData.MoveTarget.ALL_ALLIES)):
		return

	_enemyTargetingController.initial_hover()

	return


func on_state_resumed() -> void:
	assert(false, "Not supposed to resume the select target state")

	return


func on_state_end() -> void:
	_enemyTargetingController.cancel_enemy_selection()

	return


func on_confirm_clicked() -> void:
	print("player select target battle state confirm clicked")
	var _targetEnemiesIds: Array[int] = _enemyTargetingController.get_selected_enemies_ids()
	_enemyTargetingController.cancel_enemy_selection()
	_stateMachine.pop_stack(PlayerAttackResultState.new(_battleMove, _targetEnemiesIds, _stateMachine))

	return


func on_left_arrow_clicked() -> void:
	_enemyTargetingController.hover_previous_enemy()
	return


func on_right_arrow_clicked() -> void:
	_enemyTargetingController.hover_next_enemy()
	return


func on_down_arrow_clicked() -> void:
	return


func on_up_arrow_clicked() -> void:
	return


func on_back_clicked() -> void:
	print("player_select_target_state on back clicked. Popping state")
	_stateMachine.pop_state()

	return
