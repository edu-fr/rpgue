class_name DataManager
extends Node

const _BASE_DATA_PATH: String = "res://assets/data/"
const _SAVE_DATA_PATH: String = "user://save_data.json"
# MUST MATCH DATA FILE NAME
enum DataFileName { NONE, EXTERNAL_DATA }
var _loadedSaveData: SaveData
var _externalGameConfig: ExternalGameConfig

var currentInGameData: InGameData
var currentRunData: RunData


func init() -> void:
	_loadOrCreateSaveData()
	_import_external_data()

	return


func save_current_data_to_save_file() -> void:
	var jsonSaveData: Dictionary = JsonClassConverter.class_to_json(_loadedSaveData)
	JsonClassConverter.store_json_file(_SAVE_DATA_PATH, jsonSaveData)

	print("Data successfully saved to file!")

	return


func erase_run_data() -> void:
	if (!FileAccess.file_exists(_SAVE_DATA_PATH)):
		print("Can't erase run data. Save file not found")
		return

	update_run_data(RunData.new())

	return


func update_run_data(runData: RunData) -> void:
	print("Updating run data...")
	_loadedSaveData.set_run_data(runData)
	save_current_data_to_save_file()

	return


func update_in_game_data(inGameData: InGameData) -> void:
	print("Updating in game data...")
	_loadedSaveData.set_in_game_data(inGameData)
	save_current_data_to_save_file()

	return


func get_upgrades_data() -> Dictionary:
	return _externalGameConfig.get_upgrades_data()


func get_monsters_data() -> Dictionary:
	return _externalGameConfig.get_monsters_data()


func _load_data_from_save_file() -> bool:
	if (FileAccess.file_exists(_SAVE_DATA_PATH)):
		var loadedData: SaveData = JsonClassConverter.json_file_to_class(SaveData, _SAVE_DATA_PATH)
		if (loadedData != null):
			_loadedSaveData = loadedData
			print("Data successfully loaded!")

			return true
		else:
			print("Data failed to load!")

			return false

	print ("Save file doesn't exists")

	return false

func _loadOrCreateSaveData() -> void:
	if (!_load_data_from_save_file()):
		_create_save_data()

	currentInGameData = _loadedSaveData.inGameData
	currentRunData = _loadedSaveData.currentRunData

	return


func _create_save_data() -> void:
	var newSaveData: SaveData = SaveData.new()
	_loadedSaveData = newSaveData
	_loadedSaveData.inGameData.increase_total_runs()
	print("New save data created!")
	save_current_data_to_save_file()

	return


func _import_external_data() -> void:
	var data: Dictionary = _get_json_from_path(DataFileName.EXTERNAL_DATA)
	_externalGameConfig = ExternalGameConfig.create_from_json(data)

	return


func _get_json_from_path(fileName: DataFileName) -> Variant:
	var _nameStr: String = DataFileName.keys()[fileName]
	var _path: String = _BASE_DATA_PATH + _nameStr.to_lower() + ".json";
	var _fileAsStr: String = FileAccess.get_file_as_string(_path)
	assert(_fileAsStr != null, "Failed to load json data at: " + _path)

	return JSON.parse_string(_fileAsStr)
