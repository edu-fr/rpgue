class_name EnemyAction

enum EnemyActionCategory { UNKNOWN = 0, NONE = 1, ATTACK = 2, HEAL = 3}
var actionCategory: EnemyActionCategory
var actionValue: int


func _init(enemyActionCategory: EnemyActionCategory, enemyActionValue: int) -> void:
	actionCategory = enemyActionCategory
	actionValue = enemyActionValue

	return
