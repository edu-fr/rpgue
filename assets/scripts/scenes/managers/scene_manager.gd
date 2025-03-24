class_name SceneManager
extends Node

const _BASE_SCENE_PATH: String = "res://assets/scenes/"
@export var GameSceneTree: Control
# MUST MATCH TSCN FILE NAME
enum SceneName { NONE, MAIN_MENU, BATTLE, UPGRADE }


func change_scene(sceneName: SceneName) -> void:
	var _path: String = _get_scene_path(sceneName)
	print("Changing to scene at: " + _path)
	var _scene: PackedScene = load(_path)
	var _sceneNode: Node    = _scene.instantiate()
	assert(_sceneNode != null, "Failed to load scene at: " + _path)

	if (GameSceneTree.get_child_count() > 0):
		var currentScene: Node = GameSceneTree.get_child(0)
		currentScene.queue_free()

	GameSceneTree.add_child(_sceneNode)

	return


func _get_scene_path(sceneName: SceneName) -> String:
	var nameStr: String    = SceneName.keys()[sceneName]
	var _scenePath: String = _BASE_SCENE_PATH + nameStr.to_lower() + ".tscn"

	return _scenePath
