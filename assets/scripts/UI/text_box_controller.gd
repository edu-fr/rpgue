class_name TextBoxController
extends Control

@export var _textBox: MarginContainer
@export var _textBoxLabel: Label

var _displayingText: bool
signal _textBoxClosed


func setup() -> void:
	_hide()

	return


func _gui_input(_event: InputEvent) -> void:
	if (!_displayingText):
		return

	if _event.is_action_pressed("ui_accept"):
		accept_event()
		_hide()
		_textBoxClosed.emit()

	return


func display_text(text: String) -> void:
	_textBoxLabel.text = text
	_textBox.show()
	_displayingText = true
	grab_focus()
	await _textBoxClosed

	return


func _hide() -> void:
	release_focus()
	_textBox.hide()
	_textBoxLabel.text = ""
	_displayingText = false

	return
