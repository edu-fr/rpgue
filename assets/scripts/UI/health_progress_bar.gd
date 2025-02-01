class_name HealthBarController

extends Control

@export var progressBar : ProgressBar

func init(max : int, current : int):
	progressBar.max_value = max
	progressBar.min_value = 0
	progressBar.value = current
	progressBar.changed

	return self

func take_damage(damageValue : int):
	progressBar.value -= damageValue

func heal(healValue : int):
	progressBar.value += healValue
