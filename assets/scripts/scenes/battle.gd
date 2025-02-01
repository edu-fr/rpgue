class_name Battle

extends Control

@export var textBoxController : TextBoxController

# Player stuff
@export var playerActionsPanel : ActionsPanelController

func _ready() -> void:
	setup_scene()
	start_battle()

func setup_scene():
	setup_UI()

func setup_UI():
	playerActionsPanel.hide()
	textBoxController.hide()
	playerActionsPanel.setup()

func spawn_enemies():
	return

func start_battle():
	await textBoxController.display_text("A wild enemy appears")
	playerActionsPanel.show()
