class_name GlobalManager
extends Node

var flowManager: FlowManager
var dataManager: DataManager
var runManager: RunManager
var verbose: bool = false


func init(main_scene: MainScene) -> void:
	flowManager = main_scene.flowManager
	dataManager = main_scene.dataManager
	runManager = main_scene.runManager

	return
