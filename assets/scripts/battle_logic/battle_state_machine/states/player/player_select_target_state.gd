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
	_stateMachine.battleScene._playerBattleUIController.hide_and_disable_moves_panels()

	return


func on_confirm_clicked() -> void:
	print("player select target battle state confirm clicked")
	var _targetEnemiesIds: Array[int] = _enemyTargetingController.get_selected_enemies_ids()
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
	_stateMachine.pop_state()

	return