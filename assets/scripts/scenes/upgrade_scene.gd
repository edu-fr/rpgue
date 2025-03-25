class_name UpgradeScene
extends Control

@export var upgradeController1: UpgradeController
@export var upgradeController2: UpgradeController
@export var upgradeController3: UpgradeController

var upgradeManager: UpgradeManager


func _ready() -> void:
	upgradeManager = UpgradeManager.new()
	_setup_buttons()

	return


func _setup_buttons() -> void:
	assert(upgradeManager != null, "Can't setup buttons without setting the upgradeManager")

	var upgrades: Array[UpgradeData] = upgradeManager.get_random_upgrades(3)
	assert(upgrades.size() == 3, "Can't setup buttons with less than 3 upgrades")
	upgradeController1.init(upgrades[0])
	upgradeController2.init(upgrades[1])
	upgradeController3.init(upgrades[2])

	return
