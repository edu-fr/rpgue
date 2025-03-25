class_name GameData

var _upgradesRawData: Dictionary = {}  # Dictionary<String, Upgrade>
var _monstersRawData: Dictionary = {}  # Dictionary<String, Upgrade>


static func from_json(json_data: Dictionary) -> GameData:
	var data: GameData = GameData.new()

	# Upgrades data
	var upgradesData: Dictionary = json_data.get("Upgrades", {})
	for key: String in upgradesData:
		var upgradeDataDict: Dictionary = upgradesData[key]
		var upgradeData: UpgradeData = UpgradeData.from_json(upgradeDataDict)
		data._upgradesRawData[key] = upgradeData

	# Monsters data
	## TODO

	return data


func get_upgrades_data() -> Dictionary:
	return _upgradesRawData.duplicate()


func get_monsters_data() -> Dictionary:
	return _monstersRawData.duplicate()