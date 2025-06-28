class_name EnemyTargetingController
extends Node

signal target_selection_finished(enemyIDs: Array[int])
var _battleMove: BattleMove
var _enemies: Array[EnemyController]
var _currentIndex: int = 0


func _init(battleMove: BattleMove, enemiesArray: Array[EnemyController]) -> void:
	_battleMove = battleMove
	_enemies = enemiesArray
	_currentIndex = 0 if _enemies.size() > 0 else -1
	_update_selection()

	return


func handle_press_left() -> void:
	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.get_move_data().targets:
		return

	_currentIndex = max(0, _currentIndex - 1)
	_update_selection()

	return


func handle_press_right() -> void:
	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.get_move_data().targets:
		return

	_currentIndex = min(_enemies.size() - 1, _currentIndex + 1)
	_update_selection()

	return


func handle_confirm_click() -> void:
	var indexes: Array[int] = _calculate_target_indices()
	var enemyIDs: Array[int]
	for i: int in indexes:
		enemyIDs.append(_enemies[i].get_id())

	print("[SIGNAL] Emitting target_selection_finished")
	target_selection_finished.emit(enemyIDs)
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
	var _indices: Array[int] = []

	if MoveData.MoveTarget.ALL_ENEMIES in _battleMove.get_move_data().targets:
		_indices.append_array(range(_enemies.size()))
		return _indices

	for target_type: MoveData.MoveTarget in _battleMove.get_move_data().targets:
		match target_type:
			MoveData.MoveTarget.CURRENT:
				if _is_valid_index(_currentIndex):
					_indices.append(_currentIndex)
			MoveData.MoveTarget.ADJACENT:
				_indices.append_array(_get_adjacent_indices(_currentIndex))
			MoveData.MoveTarget.ADJACENT_ALLIES:
				pass
			MoveData.MoveTarget.ALL_ALLIES:
				pass
			MoveData.MoveTarget.SELF:
				pass
			MoveData.MoveTarget.ALL_ENEMIES:
				pass

	return _get_unique_sorted_indices(_indices)


func _get_adjacent_indices(center_index: int) -> Array[int]:
	if not _is_valid_index(center_index):
		return []

	var _adjacent: Array[int] = []

	if center_index > 0:
		_adjacent.append(center_index - 1)
	if center_index < _enemies.size() - 1:
		_adjacent.append(center_index + 1)

	return _adjacent


func _is_valid_index(index: int) -> bool:
	return index >= 0 && index < _enemies.size()


func _get_unique_sorted_indices(indices: Array[int]) -> Array[int]:
	var _unique: Array[int] = []
	for _index: int in indices:
		if _is_valid_index(_index) && not _unique.has(_index):
			_unique.append(_index)
	_unique.sort()

	return _unique


func _highlight_targets(indices: Array[int]) -> void:
	# Implemente a lógica de highlight na sua UI
	for i: int in _enemies.size():
		var _enemy: EnemyController = _enemies[i]
		_enemy.set_selected(i in indices)

	return


func cancel_enemy_selection() -> void:
	_currentIndex = -1
	_update_selection()

	return
