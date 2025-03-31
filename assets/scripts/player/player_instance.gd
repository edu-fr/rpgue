class_name PlayerInstance
extends Resource

## RAW DATA, NOT CONSIDERING UPGRADES OR STATS CHANGES
@export var _baseData: PlayerBaseData
@export var _baseMaxHp: float
@export var _baseCurrentHp: float
@export var _baseDamage: float
##
@export var _upgrades: Dictionary


func _init() -> void:
	_baseData = PlayerBaseData.new()
	_baseMaxHp = _baseData.baseHealth
	_baseCurrentHp = _baseMaxHp
	_baseDamage = _baseData.baseDamage
	_upgrades = Dictionary()

	return


func add_upgrade(upgradeData: UpgradeData) -> void:
	assert(!_upgrades.has(upgradeData.privateName), "Player already have the upgrade " + upgradeData.privateName)
	_upgrades[upgradeData.privateName] = upgradeData

	print("Upgrade " + upgradeData.name + " added")
	_print_upgrade_list()

	return


func _print_upgrade_list() -> void:
	var string: String
	string = "Player current upgrades: "
	for upgrade: UpgradeData in _upgrades.values():
		string += " " + upgrade.name + "\n"

	print(string)

	return


func get_attack_damage() -> float:
	var finalAttackDamage: float = _baseDamage
	# Apply attack damage upgrades and stats changes

	return finalAttackDamage


func get_magic_damage() -> float:
	var finalMagicDamage: float = _baseDamage
	# Apply magic damage upgrades and stats changes

	return finalMagicDamage


func get_max_hp() -> float:
	var finalMaxHP: float = _baseMaxHp
	# Apply max HP upgrades and stats changes

	return finalMaxHP


func get_current_hp() -> float:
	var finalCurrentHP: float = _baseCurrentHp
	# Apply current HP upgrades and stats changes

	return finalCurrentHP
