class_name GameData

var upgrades: Dictionary = {}  # Dictionary<String, Upgrade>
var monsters: Dictionary = {}  # Dictionary<String, Upgrade>


static func from_json(json_data: Dictionary) -> GameData:
	var data: GameData = GameData.new()

	# Upgrades data
	var upgradesData: Dictionary = json_data.get("Upgrades", {})
	for key: String in upgradesData:
		var upgradeDataDict: Dictionary = upgradesData[key]
		var upgradeData: UpgradeData    = UpgradeData.from_json(upgradeDataDict)
		data.upgrades[key] = upgradeData

	# Monsters data
	## TODO

	return data
