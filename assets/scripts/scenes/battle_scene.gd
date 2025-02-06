class_name BattleScene

extends Control

enum BATTLE_RESULT {NONE, WIN, LOSE}
enum TURN_OWNER {NONE, PLAYER, ENEMIES}

const _enemyScenePath = "E:/Godot/Projects/rpgue/assets/prefabs/enemy.tscn"

@export var _playerController: PlayerController

@export var _enemiesHBoxContainer: HBoxContainer

@export var _textBoxController: TextBoxController

var _remainingEnemies: Array[EnemyController]

func _ready() -> void:
	_setup_scene()
	var battleResult = await _start_battle()

	if (battleResult == BATTLE_RESULT.WIN):
		print("PLAYER WIN")
	else:
		print("LOST")

	return

#region Battle Setup

func _setup_scene() -> void:
	_spawn_enemies(3)
	_setup_player()
	_setup_UI()

	return

func _setup_player() -> void:
	_playerController.init(_remainingEnemies)

func _setup_UI() -> void:
	_textBoxController.hide()

	return

func _spawn_enemies(_quantity: int) -> void:
	for i in _quantity:
		var enemy: Node = preload(_enemyScenePath).instantiate()
		var enemyController: EnemyController = enemy
		enemyController.init()

		_remainingEnemies.append(enemyController)
		_enemiesHBoxContainer.add_child(enemy)

	return

#endregion

func _start_battle() -> BATTLE_RESULT:
	await _textBoxController.display_text("A wild enemy appears")
	var battleResult = await _battle_turn_logic()

	return battleResult

#region Turn Logic

func _battle_turn_logic() -> BATTLE_RESULT:
	var nextToPlay: TURN_OWNER = TURN_OWNER.PLAYER
	var battleDecided: bool = false

	while (!battleDecided):
		nextToPlay = await _wait_turn_owner_action(nextToPlay)
		battleDecided = _playerController.get_player_health() < 0 || _remainingEnemies.size() < 0

	return BATTLE_RESULT.WIN if _playerController.get_player_health() > 0 else BATTLE_RESULT.LOSE

func _wait_turn_owner_action(nextToPlay: TURN_OWNER) -> TURN_OWNER:
	if (nextToPlay == TURN_OWNER.PLAYER):
		var playerTurnResult = await _wait_player_action()
		return _execute_player_turn_result(playerTurnResult)

	print("executing enemy action")
	# execute enemy action
	return TURN_OWNER.PLAYER

func _execute_player_turn_result(playerAction : PlayerTurnResult) -> TURN_OWNER:
	match(playerAction._actionCategory):
		PlayerTurnResult.ActionCategory.DEFEND:
			_playerController.defend()

		PlayerTurnResult.ActionCategory.ATTACK:
			_remainingEnemies[playerAction._enemyIndex]._take_damage(_playerController.get_player_attack_damage())

		PlayerTurnResult.ActionCategory.MAGIC:
			_remainingEnemies[playerAction._enemyIndex]._take_damage(_playerController.get_player_magic_damage())

	return TURN_OWNER.ENEMIES

func _wait_player_action() -> PlayerTurnResult:
	return await _playerController.start_player_turn()

func _wait_enemy_action() -> EnemyTurnResult:
	return

#endregion
