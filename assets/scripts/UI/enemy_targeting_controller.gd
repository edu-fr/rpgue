class_name EnemyTargetingController

var _battleMove: BattleMove
var _enemiesRef: Array[EnemyController]
var _hoveredEnemies: Array[int]


func _init(battleMove: BattleMove, enemiesRef: Array[EnemyController]) -> void:
	_battleMove = battleMove
	_enemiesRef = enemiesRef

	return


func initial_hover() -> void:
	# TODO: Create additional target types
	if (_battleMove.getMoveData().targets.has(MoveData.MoveTarget.ALL_ENEMIES)):
		_hover_all_enemies()
	elif (_battleMove.getMoveData().targets.has(MoveData.MoveTarget.CURRENT)):
		_hover_first_enemy()
	else: # No target
		return

	return


func _hover_first_enemy() -> void:
	_hoveredEnemies = [0]
	_on_hover_changed()

	return


func get_selected_enemies_ids() -> Array[int]:
	var _array: Array = _hoveredEnemies.map(\
		func(enemyIndex: int) -> int: return _enemiesRef[enemyIndex].enemy_id)
	var _hoveredEnemiesIds: Array[int] = []
	_hoveredEnemiesIds.assign(_array)

	return _hoveredEnemiesIds


func hover_next_enemy() -> void:
	var _last: int = _hoveredEnemies.back()
	_hoveredEnemies.remove_at(0)
	var _newIndex: int = _last + 1 if _last < (_enemiesRef.size() - 1) else 0
	_hoveredEnemies.append(_newIndex)

	_on_hover_changed()
	return


func hover_previous_enemy() -> void:
	var _first: int = _hoveredEnemies.front()
	_hoveredEnemies.remove_at(_hoveredEnemies.size() - 1)
	var _newIndex: int = _first - 1 if _first > 0 else (_enemiesRef.size() - 1)
	_hoveredEnemies.append(_newIndex)

	_on_hover_changed()
	return


func _hover_all_enemies() -> void:
	_hoveredEnemies.clear()
	for i: int in range(_enemiesRef.size()):
		_hoveredEnemies.append(i)
	_on_hover_changed()

	return


func _on_hover_changed() -> void:
	for i: int in _enemiesRef.size():
		_enemiesRef[i].set_selected(_hoveredEnemies.find(i) != -1)

	return


func cancel_enemy_selection() -> void:
	_hoveredEnemies = []
	_on_hover_changed()

	return

	#endregion
