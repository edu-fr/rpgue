extends Control

# TextBox
@export var textBoxController : TextBoxController

# Player stuff
@export var actionsPanel : Panel

func _ready() -> void:
	setup_scene()
	start_battle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup_scene():
	actionsPanel.hide()

func start_battle():
	textBoxController.display_text("A wild enemy appears")
