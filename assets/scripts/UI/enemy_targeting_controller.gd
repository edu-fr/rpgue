class_name EnemyTargetingController
extends Node

signal target_selection_finished(enemy_indices: Array[int])
var _battleMove: BattleMove
var _enemies: Array[EnemyController]
var _currentIndex: int = 0


func _init(battle_move: BattleMove, enemies_array: Array[EnemyController]) -> void:
	_battleMove = battle_move
	_enemies = enemies_array
	_currentIndex = 0 if _enemies.size() > 0 else -1
	_update_selection()

	return


func handle_left_click() -> void:
	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.getMoveData().targets:
		return

	_currentIndex = max(0, _currentIndex - 1)
	_update_selection()

	return


func handle_right_click() -> void:
	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.getMoveData().targets:
		return

	_currentIndex = min(_enemies.size() - 1, _currentIndex + 1)
	_update_selection()

	return


func handle_confirm_click() -> void:
	var indices: Array[int] = _calculate_target_indices()
	print("[SIGNAL] Emitting target_selection_finished")
	target_selection_finished.emit(indices)
	cancel_enemy_selection()
	queue_free()

	return


func handle_back_click() -> void:
	cancel_enemy_selection()

	return


func _update_selection() -> void:
	var indices: Array[int] = _calculate_target_indices()
	_highlight_targets(indices)

	return


func _calculate_target_indices() -> Array[int]:
	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.getMoveData().targets:
		return range(_enemies.size())

	var indices: Array[int] = []

	for target_type: MoveData.MoveTarget in _battleMove.getMoveData().targets:
		match target_type:
			MoveData.MoveTarget.CURRENT:
				if _is_valid_index(_currentIndex):
					indices.append(_currentIndex)
			MoveData.MoveTarget.ADJACENT:
				indices += _get_adjacent_indices(_currentIndex)
			MoveData.MoveTarget.ADJACENT_ALLIES:
				pass
			MoveData.MoveTarget.ALL_ALLIES:
				pass
			MoveData.MoveTarget.SELF:
				pass
			MoveData.MoveTarget.ALL_ENEMIES:
				pass

	return _get_unique_sorted_indices(indices)


func _get_adjacent_indices(center_index: int) -> Array[int]:
	if not _is_valid_index(center_index):
		return []

	var adjacent: Array[int] = []

	if center_index > 0:
		adjacent.append(center_index - 1)
	if center_index < _enemies.size() - 1:
		adjacent.append(center_index + 1)

	return adjacent


func _is_valid_index(index: int) -> bool:
	return index >= 0 && index < _enemies.size()


func _get_unique_sorted_indices(indices: Array[int]) -> Array[int]:
	var unique: Array[int] = []
	for index: int in indices:
		if _is_valid_index(index) && not unique.has(index):
			unique.append(index)
	unique.sort()

	return unique


func _highlight_targets(indices: Array[int]) -> void:
	# Implemente a lógica de highlight na sua UI
	for i: int in _enemies.size():
		var enemy: EnemyController = _enemies[i]
		enemy.set_selected(i in indices)

	return


func cancel_enemy_selection() -> void:
	_currentIndex = -1
	_update_selection()

	return
