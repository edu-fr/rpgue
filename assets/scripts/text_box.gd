class_name TextBoxController

extends Control

# Textbox
@export var textBox : MarginContainer
@export var textBoxLabel : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textBox.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and :
		textBox.hide()

func display_text(text):
	textBoxLabel.text = text
	textBox.show()
