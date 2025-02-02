class_name TextBoxController

extends Control

@export var textBox : MarginContainer
@export var textBoxLabel : Label

signal textBoxClosed

func _input(_event) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		textBox.hide()
		textBoxClosed.emit()

func display_text(_text):
	textBoxLabel.text = _text
	textBox.show()
	await textBoxClosed
