class_name TextBoxController

extends Control

@export var _textBox: MarginContainer
@export var _textBoxLabel: Label

signal _textBoxClosed

func setup() -> void:
	_textBox.hide()
	_textBoxLabel.text = ""

	return

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_textBox.hide()
		_textBoxClosed.emit()

	return

func display_text(text) -> void:
	_textBoxLabel.text = text
	_textBox.show()
	await _textBoxClosed

	return
