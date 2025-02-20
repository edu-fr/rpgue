class_name PlayerAction

enum ActionCategory {NONE, ATTACK, MAGIC, DEFEND}
var _actionCategory: ActionCategory
var _enemiesIds: Array[int]


func _init(actionCategory: ActionCategory, enemiesIds: Array[int]) -> void:
	_actionCategory = actionCategory
	_enemiesIds = enemiesIds

	return