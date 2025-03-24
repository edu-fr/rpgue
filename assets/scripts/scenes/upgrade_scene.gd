class_name UpgradeScene
extends Control

@export var upgradeController1: UpgradeController
@export var upgradeController2: UpgradeController
@export var upgradeController3: UpgradeController


func _ready() -> void:
	upgradeController1.init()
	upgradeController2.init()
	upgradeController3.init()

	return
