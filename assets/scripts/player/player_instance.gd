class_name PlayerInstance
extends Resource

@export var baseData: PlayerBaseData
@export var maxHp: float
@export var currentHp: float
@export var damage: float
@export var upgrades: Dictionary


func _init() -> void:
	baseData = PlayerBaseData.new()
	maxHp = baseData.baseHealth
	currentHp = maxHp
	damage = baseData.baseDamage
	upgrades = Dictionary()

	return


func add_upgrade(upgradeData: UpgradeData) -> void:
	assert(!upgrades.has(upgradeData.privateName), "Player already have the upgrade " + upgradeData.privateName)
	upgrades[upgradeData.privateName] = upgradeData

	print("Upgrade " + upgradeData.name + " added")
	_print_upgrade_list()

	return


func _print_upgrade_list() -> void:
	var string: String
	string = "Player current upgrades: "
	for upgrade: UpgradeData in upgrades.values():
		string += " " + upgrade.name + "\n"

	print(string)

	return
