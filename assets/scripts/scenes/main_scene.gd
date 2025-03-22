class_name MainScene
extends Node

static var instance: MainScene

@export var flowManager: FlowManager


func _ready() -> void:
	GM.setup(self)

	print("Game started")
	flowManager.boot_sequence()

	return