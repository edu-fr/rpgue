class_name EnemyController

extends Control

@export var _healthBar: HealthBarController
@export var _enemyImage: TextureRect

func init():
	_setup_health_bar(50, 35)

	return self;

func on_damage_received(damage: int) -> void:
	_take_damage(damage)

	if (!_healthBar.get_enemy_alive()):
		print("morri")

	return

func _setup_health_bar(maxHealth: int, current: int = -1) -> void:
	_healthBar.init(maxHealth, current)

func _take_damage(damageValue: int) -> void:
	_healthBar.take_damage(damageValue)

func _heal(healValue: int) -> void:
	_healthBar.heal(healValue)

func set_selected(value: bool) -> void:
	_enemyImage.modulate = Color(1.5, 1.5, 1.5) if value else Color(1, 1, 1)