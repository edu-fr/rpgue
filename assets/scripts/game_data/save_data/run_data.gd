class_name RunData
extends Resource

@export var levelsBeated: int
var playerRunData: PlayerRunData


func _init() -> void:
	levelsBeated = 0

	# Load from file or get default class values
	var _playerClassData: PlayerClassData = GM.dataManager.get_player_default_class_data()
	playerRunData = PlayerRunData.new(10, _playerClassData.baseMaxHP, _playerClassData.baseMaxHP, _playerClassData.baseDamageMultiplier, _playerClassData.baseDamageMultiplier, _playerClassData.initialMoveNameList) # ID synced with enemy limit on battle scene

	return


func on_level_beated() -> void:
	levelsBeated += 1

	return


func get_player_battle_actor() -> PlayerBattleActor:
	return playerRunData.create_battle_actor_from_run_data()
