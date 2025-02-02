class_name EnemyController

extends Control

@export var _healthBar : HealthBarController

func init():
	_setup_health_bar(50, 35)

	return self;

func _setup_health_bar(maxHealth : int, current : int = -1):
	_healthBar.init(maxHealth, current)

func _take_damage(damageValue : int):
	_healthBar.take_damage(damageValue)

func _heal(healValue : int):
	_healthBar.heal(healValue)
