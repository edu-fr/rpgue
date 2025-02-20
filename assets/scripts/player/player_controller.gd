class_name PlayerController
extends Node

@export var _statusPanel: PlayerStatusPanelController
@export var _actionsPanel: ActionsPanelController
@export var _playerInitialMaxHealth: int
@export var _playerInitialCurrentHp: int


func init() -> void:
	_statusPanel.init(_playerInitialMaxHealth, _playerInitialCurrentHp)
	_actionsPanel.init()

	return


func start_player_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	return await _actionsPanel.start_turn(remainingEnemies)


func get_player_health() -> int:
	return _statusPanel.get_player_current_health()


func is_player_alive() -> bool:
	return _statusPanel.get_player_current_health() > 0


func defend() -> void:
	print("Defend")


func get_player_attack_damage() -> int:
	return 10


func get_player_magic_damage() -> int:
	return 15


func damage_player(damage: int) -> bool:
	_statusPanel.damage_player(damage)

	return is_player_alive()
