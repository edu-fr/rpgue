class_name MainMenuScene
extends Control

@export var startButton: Button
@export var optionsButton: Button
@export var quitButton: Button


func _ready() -> void:
	startButton.pressed.connect(_on_start_pressed)
	optionsButton.pressed.connect(_on_options_pressed)
	quitButton.pressed.connect(_on_quit_pressed)

	return


func _on_start_pressed() -> void:
	GM.flowManager.go_to_run_map()

	return


func _on_options_pressed() -> void:
	print("options")

	return


func _on_quit_pressed() -> void:
	get_tree().quit()

	return
