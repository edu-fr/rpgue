class_name PlayerInstance
extends Resource

@export var baseData: PlayerBaseData
@export var maxHp: int
@export var currentHp: int
@export var damage: int
@export var upgrades: Dictionary


func _init() -> void:
	baseData = PlayerBaseData.new()
	maxHp = baseData.baseHealth
	currentHp = maxHp
	damage = baseData.baseDamage
	upgrades = Dictionary()

	return


func add_upgrade(upgradeData: UpgradeData) -> void:
	assert(!upgrades.has(upgradeData.id), "Player already have the upgrade " + upgradeData.name)
	upgrades[upgradeData.id] = upgradeData

	return
