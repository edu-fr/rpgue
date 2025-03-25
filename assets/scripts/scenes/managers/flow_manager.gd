class_name FlowManager
extends Node

@export var _sceneManager: SceneManager


func boot_sequence() -> void:
	print("Starting boot sequence")
	go_to_menu()

	return


func go_to_menu() -> void:
	print("Opening MainMenu")
	_sceneManager.change_scene(_sceneManager.SceneName.MAIN_MENU)

	return


func go_to_battle() -> void:
	print("Opening Battle")
	_sceneManager.change_scene(_sceneManager.SceneName.BATTLE)

	return


func open_upgrade_scene() -> void:
	print("Opening upgrade scene")
	_sceneManager.change_scene(_sceneManager.SceneName.UPGRADE)

	Utils.remove_key_action(KEY_F)

	return