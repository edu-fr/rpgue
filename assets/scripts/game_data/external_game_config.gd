class_name ExternalGameConfig

var _movesRawConfig: Dictionary[String, MoveData] = {}  # Dictionary<String, Move>
var _upgradesRawConfig: Dictionary[String, UpgradeData] = {}  # Dictionary<String, Upgrade>
var _monstersRawConfig: Dictionary = {}  # Dictionary<String, Upgrade>

## DEBUG
static var _verboseLog: bool = false
##

static func create_from_json(jsonData: Dictionary) -> ExternalGameConfig:
	var _config: ExternalGameConfig = ExternalGameConfig.new()

	var _movesData: Dictionary = jsonData.get("Moves", {})
	for key: String in _movesData.keys():
		var _movesDataDict: Dictionary = _movesData[key]
		var _moveData: MoveData = MoveData.create_from_json(_movesDataDict)
		_config._movesRawConfig[key] = _moveData

	var _upgradesData: Dictionary = jsonData.get("Upgrades", {})
	for key: String in _upgradesData.keys():
		var _upgradesDataDict: Dictionary = _upgradesData[key]
		var _upgradeData: UpgradeData = UpgradeData.create_from_json(_upgradesDataDict)
		_config._upgradesRawConfig[key] = _upgradeData

	# Monsters data
	## TODO

	if (_verboseLog):
		print("########### MOVES DATA ##############\n")
		for _moveData: MoveData in _config._movesRawConfig.values():
			print("MOVE: " + _moveData.name)
			print(_moveData)
		print("\n#####################################")

		print("########### UPGRADES DATA ##############\n")
		for _upgradeData: UpgradeData in _config._upgradesRawConfig.values():
			print("UPGRADE: " + _upgradeData.name)
			print(_upgradeData)
		print("\n########################################")

	print("External data successfully imported!")

	return _config


func get_upgrades_data() -> Dictionary[String, UpgradeData]:
	return _upgradesRawConfig.duplicate(true)


func get_monsters_data() -> Dictionary:
	return _monstersRawConfig.duplicate(true)


func get_player_default_data() -> PlayerBaseData:
	return PlayerBaseData.new() # TODO: import this stats


func mock_get_X_moves_of_type(category: MoveData.Category, amount: int) -> Array[MoveData]:
	assert(category != null, "Move category can't be null")
	assert(_movesRawConfig.values().size() > 0, "Couldn't find any moves on raw config")

	var moves_array: Array[MoveData] = []
	for move: MoveData in _movesRawConfig.values():
		if move.category == category:
			moves_array.append(move)

	moves_array.shuffle()
	assert(moves_array.size() >= amount, "Can't get " + str(amount) + "of moves from category")

	var result: Array[MoveData] = moves_array.slice(0, amount)

	return result