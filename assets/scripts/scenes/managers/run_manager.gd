class_name RunManager
extends Node

var currentRunDataRef: RunData


func init() -> void:
	_load_or_create_run()

	return


func create_new_run() -> void:
	currentRunDataRef = RunData.new()
	GM.dataManager.update_run_data(currentRunDataRef)

	return


func _load_or_create_run() -> void:
	currentRunDataRef = GM.dataManager.currentRunData
	if (currentRunDataRef == null):
		print("No run info found. Creating a new run")
		create_new_run()

	return
