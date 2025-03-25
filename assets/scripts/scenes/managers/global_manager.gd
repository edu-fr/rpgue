class_name GlobalManager
extends Node

var flowManager: FlowManager
var dataManager: DataManager


func init(main_scene: MainScene) -> GlobalManager:
	flowManager = main_scene.flowManager
	dataManager = main_scene.dataManager

	return self
