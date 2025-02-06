class_name PlayerStatusPanelController

extends Control

@export var playerName : String
@export var _healthBarController : HealthBarController

func init(maxHp : int, currentHp : int) -> void:
	_healthBarController.init(maxHp, currentHp)

func get_player_current_health() -> int:
	return _healthBarController.get_current_health()
