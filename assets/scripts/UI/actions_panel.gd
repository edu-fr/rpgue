class_name ActionsPanelController

extends Control

# Textbox
@export var attackButton : Button
@export var magicButton : Button
@export var defendButton : Button

func setup() -> void:
	attackButton.pressed.connect(on_attack_button_pressed)
	magicButton.pressed.connect(on_magic_button_pressed)
	defendButton.pressed.connect(on_defend_button_pressed)

func on_attack_button_pressed() -> void:
	print("attack")
	return

func on_magic_button_pressed() -> void:
	print("magic")
	return

func on_defend_button_pressed() -> void:
	print("defend")
	return
