class_name ExternalGameConfig

var _upgradesRawConfig: Dictionary = {}  # Dictionary<String, Upgrade>
var _monstersRawConfig: Dictionary = {}  # Dictionary<String, Upgrade>


static func create_from_json(json_data: Dictionary) -> ExternalGameConfig:
	var config: ExternalGameConfig = ExternalGameConfig.new()

	# Upgrades data
	var upgradesData: Dictionary = json_data.get("Upgrades", {})
	for key: String in upgradesData:
		var upgradeDataDict: Dictionary = upgradesData[key]
		var upgradeData: UpgradeData = UpgradeData.create_from_json(upgradeDataDict)
		config._upgradesRawConfig[key] = upgradeData

	# Monsters data
	## TODO

	return config


func get_upgrades_data() -> Dictionary:
	return _upgradesRawConfig.duplicate()


func get_monsters_data() -> Dictionary:
	return _monstersRawConfig.duplicate()