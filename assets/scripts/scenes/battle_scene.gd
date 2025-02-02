class_name BattleScene

extends Control

const _enemyScenePath = "E:/Godot/Projects/rpgue/assets/prefabs/enemy.tscn"

@export var _playerActionsPanel : ActionsPanelController

@export var _enemiesHBoxContainer : HBoxContainer

@export var _textBoxController : TextBoxController

func _ready() -> void:
	_setup_scene()
	_start_battle()

	return

func _setup_scene() -> void:
	setup_UI()
	_spawn_enemies(3)

	return

func setup_UI() -> void:
	_playerActionsPanel.setup()
	_playerActionsPanel.hide()

	_textBoxController.hide()
	return

func _spawn_enemies(_quantity : int) -> void:
	for i in _quantity:
		var enemy : Node = preload(_enemyScenePath).instantiate()
		var enemyController : EnemyController = enemy
		enemyController.init()

		_enemiesHBoxContainer.add_child(enemy)
	return

func _start_battle() -> void:
	await _textBoxController.display_text("A wild enemy appears")
	_playerActionsPanel.show()
	return
