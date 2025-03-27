class_name InGameData
extends Resource

@export var totalRuns: int
@export var wins: int


func _init() -> void:
	totalRuns = 0
	wins = 0

	return

func increase_total_runs() -> void:
	totalRuns += 1

	return


func increase_total_wins() -> void:
	wins += 1

	return