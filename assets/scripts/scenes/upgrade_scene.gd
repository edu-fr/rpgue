class_name UpgradeScene
extends Control

@export var improvementController1: ImprovementController
@export var improvementController2: ImprovementController
@export var improvementController3: ImprovementController

var improvementManager: ImprovementManager


func _ready() -> void:
	improvementManager = ImprovementManager.new()

	var decider: Dictionary
	decider[0] = "moves"
	decider[1] = "upgrades"
	var choose: String = decider[randi() % decider.size()]

	_setup_buttons(choose)

	return


func _setup_buttons(decider: String) -> void:
	assert(improvementManager != null, "Can't setup buttons without setting the improvementManager")

	if (decider == "moves"):
		var moves: Array[MoveData] = improvementManager.get_random_moves(3)
		assert(moves.size() == 3, "Can't setup buttons with less than 3 moves")
		improvementController1.init(moves[0].name, moves[0].description, moves[0].privateName, _on_move_clicked)
		improvementController2.init(moves[1].name, moves[1].description, moves[1].privateName, _on_move_clicked)
		improvementController3.init(moves[2].name, moves[2].description, moves[2].privateName, _on_move_clicked)
	elif (decider == "upgrades"):
		var upgrades: Array[UpgradeData] = improvementManager.get_random_upgrades(3)
		assert(upgrades.size() == 3, "Can't setup buttons with less than 3 upgrades")
		improvementController1.init(upgrades[0].name, upgrades[0].description, upgrades[0].privateName, _on_upgrade_clicked)
		improvementController2.init(upgrades[1].name, upgrades[1].description, upgrades[1].privateName, _on_upgrade_clicked)
		improvementController3.init(upgrades[2].name, upgrades[2].description, upgrades[2].privateName, _on_upgrade_clicked)
	else:
		push_error("Not expected decider")

	return


func _on_upgrade_clicked(upgradePrivateName: String) -> void:
	GM.runManager.currentRunDataRef.on_upgrade_received(upgradePrivateName)
	GM.flowManager.go_to_run_map()

	return


func _on_move_clicked(movePrivateName: String) -> void:
	GM.runManager.currentRunDataRef.on_move_received(movePrivateName)
	GM.flowManager.go_to_run_map()

	return
