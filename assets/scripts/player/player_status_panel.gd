class_name PlayerStatusPanelController

extends Control

@export var playerName : String
@export var _healBarController : HealthBarController

func init(maxHp : int, currentHp : int) -> void:
	_healBarController.init(maxHp, currentHp)

