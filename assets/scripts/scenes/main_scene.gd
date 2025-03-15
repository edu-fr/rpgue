extends Node

@export var flowManager: FlowManager

func _ready() -> void:
	print("Game started")
	flowManager.boot_sequence()
