class_name HealthProgressBarController
extends Control

@export var _progressBar: ProgressBar
@export var _label: Label


func init(_max: float, _current: float) -> void:
	_progressBar.max_value = _max
	_progressBar.min_value = 0
	_progressBar.value = _current if _current >= 0 else _max
	update_label()

	return


func update_value(oldValue: float, newValue: float, animate: bool) -> void:
	if (newValue > _progressBar.value):
		if (animate):
			# TODO: Health upgrade animation/SFX
			print("Healed HP!")
	elif (newValue < _progressBar.value):
		if (animate):
			# TODO: Health downgrade animation/SFX
			print("Lose HP!")
	else:
		return

	_progressBar.value = newValue
	update_label()

	return


func update_max_value(oldMaxValue: float, newMaxValue: float, animate: bool) -> void:
	if (newMaxValue > _progressBar.max_value):
		if (animate):
			# TODO: Health upgrade animation/SFX
			print("Max HP upgrade!")
	elif (newMaxValue < _progressBar.max_value):
		if (animate):
			# TODO: Health downgrade animation/SFX
			print("Max HP downgrade!")
	else:
		return

	_progressBar.max_value = newMaxValue
	update_label()

	return


func update_label() -> void:
	_label.text = "{0}/{1}".format([_progressBar.value, _progressBar.max_value])

	return
