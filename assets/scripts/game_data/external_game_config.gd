class_name ExternalGameConfig

var _movesRawConfig: Dictionary[String, MoveData] = {}  # Dictionary<String, Move>
var _upgradesRawConfig: Dictionary[String, UpgradeData] = {}  # Dictionary<String, Upgrade>
var _monstersRawConfig: Dictionary = {}  # Dictionary<String, Upgrade>

## DEBUG
static var _verboseLog: bool = false
##

static func create_from_json(json_data: Dictionary) -> ExternalGameConfig:
	var _config: ExternalGameConfig = ExternalGameConfig.new()

	var _movesData: Dictionary = json_data.get("Moves", {})
	for key: String in _movesData.keys():
		var _movesDataDict: Dictionary = _movesData[key]
		var _moveData: MoveData = MoveData.create_from_json(_movesDataDict)
		_config._movesRawConfig[key] = _moveData

	var _upgradesData: Dictionary = json_data.get("Upgrades", {})
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
	return _upgradesRawConfig.duplicate()


func get_monsters_data() -> Dictionary:
	return _monstersRawConfig.duplicate()
