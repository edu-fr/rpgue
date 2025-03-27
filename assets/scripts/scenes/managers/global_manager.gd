class_name GlobalManager
extends Node

var flowManager: FlowManager
var dataManager: DataManager
var runManager: RunManager


func init(main_scene: MainScene) -> void:
	flowManager = main_scene.flowManager
	dataManager = main_scene.dataManager
	runManager = main_scene.runManager

	return
