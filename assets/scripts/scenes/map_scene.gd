class_name MapScene
extends Control

@export var _stageButtons: Array[Button]

func _ready() -> void:
	if (GM.runManager.currentRunDataRef == null):
		GM.runManager.create_new_run()

	var runDataRef: RunData = GM.runManager.currentRunDataRef

	for i: int in _stageButtons.size():
		_stageButtons[i].disabled = i != runDataRef.levelsBeated
		if (i == runDataRef.levelsBeated):
			_stageButtons[i].pressed.connect(_on_stage_clicked)

	return


func _on_stage_clicked() -> void:
	GM.flowManager.go_to_battle()

	return
