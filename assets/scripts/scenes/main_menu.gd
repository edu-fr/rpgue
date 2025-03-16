class_name MainMenu
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
	Main.flowManager.go_to_battle()
	return


func _on_options_pressed() -> void:
	print("options")
	return


func _on_quit_pressed() -> void:
	print("quit")
	return
