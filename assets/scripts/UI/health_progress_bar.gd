class_name HealthBarController

extends Control

@export var progressBar : ProgressBar
@export var label : Label

func init(_max : int, _current : int) -> void:
	progressBar.max_value = _max
	progressBar.min_value = 0
	progressBar.value = _current
	update_label()

	return

func take_damage(_damageValue : int) -> void:
	progressBar.value -= _damageValue
	update_label()

func heal(_healValue : int) -> void:
	progressBar.value += _healValue
	update_label()

func update_label() -> void:
	label.text = "{0}/{1}".format([progressBar.value, progressBar.max_value])
