class_name SaveData
extends Resource

@export var inGameData : InGameData
@export var currentRunData : RunData


func _init() -> void:
	inGameData = InGameData.new()
	currentRunData = null

	return


func set_run_data(runData: RunData) -> void:
	currentRunData = runData;

	return

func set_in_game_data(gameData: InGameData) -> void:
	inGameData = gameData;

	return