class_name PlayerAction

enum ActionCategory {NONE, ATTACK, MAGIC, DEFEND}
var _actionCategory: ActionCategory
var _enemiesIndex: Array[int]


func _init(actionCategory: ActionCategory, enemiesIndex: Array[int]) -> void:
	_actionCategory = actionCategory
	_enemiesIndex = enemiesIndex

	return