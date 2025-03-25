class_name MainScene
extends Node

static var instance: MainScene

@export var flowManager: FlowManager
@export var dataManager: DataManager


func _ready() -> void:
	GM.init(self)

	dataManager.init()

	print("Game started")
	flowManager.boot_sequence()

	return