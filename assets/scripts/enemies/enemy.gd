class_name EnemyController

extends Control

@export var healthBar : HealthBarController

func init():
	setup_health_bar(50, 35)

	return self;

func setup_health_bar(_max : int, _current : int = -1):
	healthBar.init(_max, _current)

func take_damage(_damageValue : int):
	healthBar.take_damage(_damageValue)

func heal(_healValue : int):
	healthBar.heal(_healValue)
