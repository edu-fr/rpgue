class_name PlayerController

extends Node

@export var _statusPanel : PlayerStatusPanelController
@export var _actionsPanel : ActionsPanelController
@export var _playerInitialMaxHealth: int
@export var _playerInitialCurrentHp: int

func init(enemiesToFight: Array[EnemyController]) -> void:
	_statusPanel.init(_playerInitialMaxHealth, _playerInitialCurrentHp)
	_actionsPanel.init(enemiesToFight)

func start_player_turn() -> PlayerTurnResult:
	return await _actionsPanel.start_turn()

func get_player_health() -> int:
	return _statusPanel.get_player_current_health()
	
func defend() -> void:
	print("Defend")

func get_player_attack_damage() -> int:
	return 10

func get_player_magic_damage() -> int:
	return 15
