class_name PlayerStatusPanelController
extends Control

@export var _playerName: String = "Default"
@export var _playerNameLabel: Label
@export var _healthBarController: HealthBarController
var _playerBattleActor: PlayerBattleActor


func init(playerBattleActor: PlayerBattleActor) -> void:
	_playerNameLabel.text = _playerName
	_playerBattleActor = playerBattleActor
	_healthBarController.init(playerBattleActor.get_max_HP(), playerBattleActor.get_current_HP())
	playerBattleActor.current_hp_changed.connect(_healthBarController.update_value)
	playerBattleActor.max_hp_changed.connect(_healthBarController.update_max_value)

	return


func get_player_current_health() -> float:
	return _playerBattleActor.get_current_HP()


func damage_player(value: float) -> void:
	_playerBattleActor.take_damage(value)

	return


func heal_player(value: float) -> void:
	_playerBattleActor.heal(value)

	return;