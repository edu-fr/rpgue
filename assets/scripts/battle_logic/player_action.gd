class_name PlayerAction

enum ActionCategory {NONE, ATTACK, MAGIC, DEFEND}
var _actionCategory: ActionCategory
var _enemyIndex: int


func _init(actionCategory: ActionCategory, enemyIndex: int) -> void:
	_actionCategory = actionCategory
	_enemyIndex = enemyIndex

	return