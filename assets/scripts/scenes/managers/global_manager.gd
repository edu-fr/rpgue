class_name GlobalManager
extends Node

var flowManager: FlowManager
var dataManager: DataManager
var runManager: RunManager
var rng: RandomNumberGenerator
var verbose: bool = false


func init(main_scene: MainScene) -> void:
	flowManager = main_scene.flowManager
	dataManager = main_scene.dataManager
	runManager = main_scene.runManager
	rng = RandomNumberGenerator.new() # The seed is set in the RunManager on the start of each run

	return
