class_name MainScene
extends Node

static var instance: MainScene

@export var flowManager: FlowManager
@export var dataManager: DataManager
@export var runManager: RunManager


func _ready() -> void:
	_boot()

	flowManager.go_to_main_menu()
	return


func _boot() -> void:
	print("Boot started")

	GM.init(self)
	dataManager.init()
	runManager.init()

	print("Boot finished")

	return


## DEBUG
func _process(_delta: float) -> void:
	Utils._check_key_actions()
