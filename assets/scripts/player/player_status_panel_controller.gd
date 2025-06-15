class_name PlayerStatusPanelController
extends Control

@export var _playerName: String = "Default"
@export var _playerNameLabel: Label
@export var _healthBarController: HealthBarController


func init(playerInstance: PlayerInstance) -> void:
	_playerNameLabel.text = _playerName
	_healthBarController.init(playerInstance.get_max_HP(), playerInstance.get_current_HP())
	playerInstance.current_hp_changed.connect(_healthBarController.update_value)
	playerInstance.max_hp_changed.connect(_healthBarController.update_max_value)

	return


func get_player_current_health() -> float:
	return _healthBarController.get_current_health()


func damage_player(value: float) -> void:
	_healthBarController.take_damage(value)

	return


func heal_player(value: float) -> void:
	_healthBarController.heal(value)

	return;