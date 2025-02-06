class_name PlayerController

extends Node

@export var _statusPanel : PlayerStatusPanelController
@export var _playerInitialMaxHealth: int
@export var _playerInitialCurrentHp: int

func _init() -> void:
	_statusPanel.init(_playerInitialMaxHealth, _playerInitialCurrentHp)

func defend() -> void:
	print("Defend")

func get_player_attack_damage() -> int:
	return 10

func get_player_magic_damage() -> int:
	return 15
