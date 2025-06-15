class_name EnemyController
extends Control

@export var _healthBar: HealthBarController
@export var _enemyImage: TextureRect

var _enemyInstance: EnemyInstance
var enemy_id: int


func init(enemyInstance: EnemyInstance, id: int) -> void:
	enemyInstance = _enemyInstance

	_setup_health_bar(enemyInstance.get_max_HP(), enemyInstance.get_current_HP())
	enemy_id = id

	return


func receive_player_attack(moveData: MoveData) -> void:
	_alive_assertion()

	_take_damage(moveData.baseDamage)

	if (!is_alive()):
		_on_death()

	return


func heal(healValue: int) -> void:
	_alive_assertion()

	_healthBar.heal(healValue)

	return


func set_selected(value: bool) -> void:
	_alive_assertion()

	_enemyImage.modulate = Color(1.5, 1.5, 1.5) if value else Color(1, 1, 1)

	return


func set_semi_selected(value: bool) -> void:
	_alive_assertion()

	_enemyImage.modulate = Color(1.3, 1.3, 1.3) if value else Color(1, 1, 1)

	return


func is_alive() -> bool:
	return _enemyInstance.alive()


func get_random_move() -> BattleMove:
	return _enemyInstance.get_random_move()


func _setup_health_bar(maxHealth: float, current: float = -1) -> void:
	_healthBar.init(maxHealth, current)

	return


func _take_damage(damageValue: float) -> void:
	_alive_assertion()

	_healthBar.take_damage(damageValue)

	return


func _on_death() -> void:
	# Death animation
	_enemyImage.visible = false
	_healthBar.visible = false

	return


func _alive_assertion() -> void:
	assert(is_alive(), "Dead enemies should't execute any action")
