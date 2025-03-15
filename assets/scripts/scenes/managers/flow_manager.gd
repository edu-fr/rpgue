class_name FlowManager
extends Node

@export var _sceneManager : SceneManager

func boot_sequence() -> void:
	print("Starting boot sequence")
	_go_to_menu()

	return

func _go_to_menu() -> void:
	print("Opening MainMenu")
	_sceneManager.change_scene_2D(_sceneManager.Scene2DName.MAIN_MENU)