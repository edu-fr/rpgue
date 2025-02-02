class_name Battle

extends Control

const enemyScenePath = "E:/Godot/Projects/rpgue/assets/prefabs/enemy.tscn"

@export var playerActionsPanel : ActionsPanelController

@export var enemiesHBoxContainer : HBoxContainer

@export var textBoxController : TextBoxController

func _ready() -> void:
	setup_scene()
	start_battle()

	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setup_scene() -> void:
	setup_UI()
	spawn_enemies(3)

	return

func setup_UI() -> void:
	playerActionsPanel.setup()
	playerActionsPanel.hide()

	textBoxController.hide()
	return

func spawn_enemies(_quantity : int) -> void:
	for i in _quantity:
		var enemy : Node = preload(enemyScenePath).instantiate()
		var enemyController : EnemyController = enemy
		enemyController.init()

		enemiesHBoxContainer.add_child(enemy)
	return

func start_battle() -> void:
	await textBoxController.display_text("A wild enemy appears")
	playerActionsPanel.show()
	return
