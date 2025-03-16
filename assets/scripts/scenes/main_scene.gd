class_name MainScene
extends Node

@export var flowManager: FlowManager

func _ready() -> void:
	if (flowManager == null):
		return

	print("Game started")
	flowManager.boot_sequence()

	return