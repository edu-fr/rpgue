class_name ExternalGameConfig

var _movesRawConfig: Dictionary[String, MoveData] = {}
var _upgradesRawConfig: Dictionary[String, UpgradeData] = {}
var _enemiesRawConfig: Dictionary[String, EnemyData] = {}
var _playerClassesRawConfig: Dictionary[String, PlayerClassData] = {}

## DEBUG
static var _verbose: bool = true
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

	var _enemiesData: Dictionary = jsonData.get("Enemies", {})
	for key: String in _enemiesData.keys():
		var _enemiesDataDict: Dictionary = _enemiesData[key]
		var _enemyData: EnemyData = EnemyData.create_from_json(_enemiesDataDict)
		_config._enemiesRawConfig[key] = _enemyData

	var _playerClassesData: Dictionary = jsonData.get("Player Classes", {})
	for key: String in _playerClassesData.keys():
		var _playerClassDataDict: Dictionary = _playerClassesData[key]
		var _playerClassData: PlayerClassData = PlayerClassData.create_from_json(_playerClassDataDict)
		_config._playerClassesRawConfig[key] = _playerClassData

	if (_verbose):
		print("\n########### MOVES DATA ##############\n")
		for _moveData: MoveData in _config._movesRawConfig.values():
			print(_moveData.to_string())
		print("\n#####################################")

		print("\n########### UPGRADES DATA ##############\n")
		for _upgradeData: UpgradeData in _config._upgradesRawConfig.values():
			print(_upgradeData.to_string())
		print("\n########################################")

		print("\n########### ENEMIES DATA ##############\n")
		for _enemyData: EnemyData in _config._enemiesRawConfig.values():
			print(_enemyData.to_string())
		print("\n########################################")

		print("\n########### PLAYER CLASSES DATA ##############\n")
		for _playerClassData: PlayerClassData in _config._playerClassesRawConfig.values():
			print(_playerClassData.to_string())
		print("\n########################################\n")

	print("External data successfully imported!")

	return _config


func get_upgrades_data() -> Dictionary[String, UpgradeData]:
	assert(_upgradesRawConfig.size() > 0, "Upgrades raw config is empty")

	return _upgradesRawConfig.duplicate(true)


func get_monsters_data() -> Dictionary:
	assert(_enemiesRawConfig.size() > 0, "Enemies raw config is empty")

	return _enemiesRawConfig.duplicate(true)


func get_player_default_class_data() -> PlayerClassData:
	assert(_playerClassesRawConfig.size() > 0, "Player classes raw config is empty")

	return _playerClassesRawConfig["hero"].duplicate()


func get_move_with_name(privateName: String) -> MoveData:
	return _movesRawConfig.find_key(privateName)


func get_enemy_with_name(privateName: String) -> EnemyData:
	return _enemiesRawConfig.find_key(privateName)


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