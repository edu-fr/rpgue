class_name PlayerStatusPanelController
extends Control

@export var _playerName: String = "Default"
@export var _playerNameLabel: Label
@export var _healthBarController: HealthBarController


func init(maxHp: float, currentHp: float) -> void:
	_healthBarController.init(maxHp, currentHp)
	_playerNameLabel.text = _playerName

	return


func get_player_current_health() -> float:
	return _healthBarController.get_current_health()


func damage_player(value: float) -> void:
	_healthBarController.take_damage(value)

	return


func heal_player(value: float) -> void:
	_healthBarController.heal(value)

	return;