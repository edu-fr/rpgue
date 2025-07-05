class_name PlayerRunData

# DATA FROM PLAYER OBJECT OF THE CURRENT RUN
# THE REST OF THE DATA FROM THE RUN WILL BE IN run_data.gd
# THIS WILL PERSIST

var _id: int
var _maxHP: float
var _currentHP: float
var _initialAttackDamageMultiplier: float
var _currentAttackDamageMultiplier: float
var _moveList: Array[String]
var _upgradeList: Array[String]


func _init(id: int, maxHP: float, currentHP: float, initialAttackDamageMultiplier: float, currentAttackDamageMultiplier: float, moveList: Array[String]) -> void:
	_id = id
	_maxHP = maxHP
	_currentHP = currentHP
	_initialAttackDamageMultiplier = initialAttackDamageMultiplier
	_currentAttackDamageMultiplier = currentAttackDamageMultiplier
	_moveList = moveList

	return


func update_run_data_from_battle_actor(updatePlayer: PlayerBattleActor) -> void:
	_maxHP = updatePlayer.get_max_HP()
	_currentHP = updatePlayer.get_current_HP()
	_currentAttackDamageMultiplier = updatePlayer.get_attack_damage_multiplier()

	return


func create_battle_actor_from_run_data() -> PlayerBattleActor:
	return PlayerBattleActor.new(_id, _maxHP, _currentHP, _currentAttackDamageMultiplier, _moveList)


func add_upgrade(upgradePrivateName: String) -> void:
	assert(!_upgradeList.has(upgradePrivateName), "Upgrade " + upgradePrivateName + " already added to player");

	_upgradeList.append(upgradePrivateName)

	return


func add_move(movePrivateName: String) -> void:
	assert(!_upgradeList.has(movePrivateName), "Move " + movePrivateName + " already added to player");

	_moveList.append(movePrivateName)

	return