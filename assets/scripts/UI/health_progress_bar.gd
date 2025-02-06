class_name HealthBarController

extends Control

@export var _progressBar: ProgressBar
@export var _label: Label

func init(_max: int, _current: int) -> void:
	_progressBar.max_value = _max
	_progressBar.min_value = 0
	_progressBar.value = _current
	update_label()

	return

func take_damage(_damageValue: int) -> void:
	_progressBar.value -= _damageValue
	update_label()

	return

func heal(_healValue: int) -> void:
	_progressBar.value += _healValue
	update_label()

	return

func update_label() -> void:
	_label.text = "{0}/{1}".format([_progressBar.value, _progressBar.max_value])

	return

func get_enemy_alive() -> bool:
	return _progressBar.value > 0
