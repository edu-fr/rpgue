class_name RunData
extends Resource

@export var levelsBeated: int
@export var playerInstance: PlayerInstance


func _init() -> void:
	levelsBeated = 0
	playerInstance = PlayerInstance.new()

	return


func on_level_beated() -> void:
	levelsBeated += 1

	return
