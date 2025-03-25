class_name DataManager
extends Node

const _BASE_DATA_PATH: String = "res://assets/data/"
# MUST MATCH DATA FILE NAME
enum DataFileName { NONE, EXTERNAL_DATA }
var _gameData: GameData


func init() -> void:
	_import_data()

	return


func get_upgrades_data() -> Dictionary:
	return _gameData.get_upgrades_data()


func _import_data() -> void:
	var data: Dictionary = _load_json_data_from_path(DataFileName.EXTERNAL_DATA)
	_gameData = GameData.from_json(data)

	return


func _load_json_data_from_path(fileName: DataFileName) -> Variant:
	var _nameStr: String = DataFileName.keys()[fileName]
	var _path: String = _BASE_DATA_PATH + _nameStr.to_lower() + ".json";
	var _fileAsStr: String = FileAccess.get_file_as_string(_path)
	assert(_fileAsStr != null, "Failed to load json data at: " + _path)

	return JSON.parse_string(_fileAsStr)
