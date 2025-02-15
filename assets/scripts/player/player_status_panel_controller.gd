class_name PlayerStatusPanelController
extends Control

@export var _playerName: String = "Default"
@export var _playerNameLabel: Label
@export var _healthBarController: HealthBarController


func init(maxHp: int, currentHp: int) -> void:
	_healthBarController.init(maxHp, currentHp)
	_playerNameLabel.text = _playerName

	return


func get_player_current_health() -> int:
	return _healthBarController.get_current_health()


func damage_player(value: int) -> void:
	_healthBarController.take_damage(value)

	return


func heal_player(value: int) -> void:
	_healthBarController.heal(value)

	return;