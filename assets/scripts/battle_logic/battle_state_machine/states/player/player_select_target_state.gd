class_name PlayerSelectTargetState
extends BaseBattleState

var _battleMove: BattleMove
var _enemyTargetingController: EnemyTargetingController
var _playerBattleActor: PlayerBattleActor

func _init(battleMove: BattleMove, playerBattleActor: PlayerBattleActor, battleStateMachine: BattleStateMachine) -> void:
	super(battleStateMachine)
	_battleMove = battleMove
	_playerBattleActor = playerBattleActor

	var enemiesRef: Array[EnemyController] = _stateMachine.battleScene._get_remaining_enemies()
	_enemyTargetingController = EnemyTargetingController.new(_battleMove, enemiesRef)
	_enemyTargetingController.target_selection_finished.connect(_on_target_selection_finished)

	return


func on_state_resumed() -> void:
	assert(false, "Not supposed to resume the select target state")

	return


func on_state_end() -> void:
	_enemyTargetingController.target_selection_finished.disconnect(_on_target_selection_finished)
	_enemyTargetingController.cancel_enemy_selection()

	return


func on_confirm_clicked() -> void:
	_enemyTargetingController.handle_confirm_click()
	return


func on_left_arrow_clicked() -> void:
	_enemyTargetingController.handle_press_left()
	return


func on_right_arrow_clicked() -> void:
	_enemyTargetingController.handle_press_right()
	return


func on_down_arrow_clicked() -> void:
	return


func on_up_arrow_clicked() -> void:
	return


func _on_target_selection_finished(enemy_indices: Array[int]) -> void:
	_stateMachine.battleScene._playerBattleUIController.on_move_selected(_battleMove)
	_stateMachine.pop_stack(PlayerAttackResultState.new(_battleMove, enemy_indices, _playerBattleActor, _stateMachine))

	return


func on_back_clicked() -> void:
	_enemyTargetingController.handle_back_click()
	_stateMachine.pop_state()

	return
