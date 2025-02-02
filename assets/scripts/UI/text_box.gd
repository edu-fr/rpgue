class_name TextBoxController

extends Control

@export var _textBox : MarginContainer
@export var _textBoxLabel : Label

signal _textBoxClosed

func _input(event) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_textBox.hide()
		_textBoxClosed.emit()

func display_text(text):
	_textBoxLabel.text = text
	_textBox.show()
	await _textBoxClosed
