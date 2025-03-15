class_name SceneManager
extends Node

const _BASE_SCENE_PATH: String = "res://assets/scenes/"
@export var SceneTree2D: Node2D
@export var SceneTreeGUI: Control
# MUST MATCH TSCN FILE NAME
enum Scene2DName { NONE, MAIN_MENU, BATTLE }
enum SceneGUIName { NONE, NAVIGATION }


func change_scene_2D(sceneName: Scene2DName) -> void:
	var _path: String  = _get_scene_path(sceneName)
	print("Changing to scene 2D at: " + _path)
	var _scene = load(_path).instantiate()
	assert(_scene != null, "Failed to load scene at: " + _path)

	var currentScene: Node2D = SceneTree2D.get_child(0)
	if (currentScene != null):
		currentScene.queue_free()

	SceneTree2D.add_child(_scene)

	return


func open_GUI(GUIName: SceneGUIName) -> void:
	var _path: String = _get_GUI_path(GUIName)
	print("Changing to GUI at: " + _path)
	var _scene: Control = load(_path).instance()

	assert(_scene != null, "Failed to load scene at: " + _path)

	SceneTreeGUI.add_child(_scene)

	return


func close_current_GUI() -> void:
	var currentGUI: Control = SceneTreeGUI.get_child(0)
	assert(currentGUI != null, "Failed to close current GUI. No GUI found")
	currentGUI.queue_free()

	return


func hide_current_GUI() -> void:
	var current_GUI: Control = SceneTreeGUI.get_child(0)
	current_GUI.hide()

	return


func _get_scene_path(sceneName: Scene2DName) -> String:
	var nameStr: String = Scene2DName.keys()[sceneName]
	var _scenePath: String = _BASE_SCENE_PATH + nameStr.to_lower() + ".tscn"

	return _scenePath


func _get_GUI_path(GUIName: SceneGUIName) -> String:
	var nameStr: String = SceneGUIName.keys()[GUIName]
	print("opening GUI scene: " + nameStr)
	var _scenePath: String = _BASE_SCENE_PATH + nameStr.to_lower() + ".tscn"

	return _scenePath
