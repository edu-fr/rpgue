class_name EnemyController

extends Control

@export var healthBar : HealthBarController

func init():
	# setup_health_bar()

	return self;

func setup_health_bar(max : int, current : int = -1):
	healthBar.init(max, current)

func take_damage(damageValue : int):
	healthBar.take_damage(damageValue)

func heal(healValue : int):
	healthBar.heal(healValue)
