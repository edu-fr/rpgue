class_name EnemyAction

enum EnemyActionCategory {NONE = 0, ATTACK = 1, HEAL = 2}
var actionCategory: EnemyActionCategory
var actionValue: int


func _init(enemyActionCategory: EnemyActionCategory, enemyActionValue: int) -> void:
	actionCategory = enemyActionCategory
	actionValue = enemyActionValue

	return
