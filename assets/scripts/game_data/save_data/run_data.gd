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


func on_level_beated(updatedPlayer: PlayerBattleActor) -> void:
	levelsBeated += 1
	playerRunData.update_run_data_from_battle_actor(updatedPlayer)

	return


func on_upgrade_received(upgradeData: UpgradeData) -> void:
	playerRunData.add_upgrade(upgradeData)

	return


func on_move_received(moveData: MoveData) -> void:
	playerRunData.add_move(moveData)

	return


func get_player_battle_actor_from_current_run_data() -> PlayerBattleActor:
	return playerRunData.create_battle_actor_from_run_data()
