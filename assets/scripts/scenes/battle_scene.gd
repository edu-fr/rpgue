class_name BattleScene
extends Control

enum BATTLE_RESULT {NONE, WIN, LOSE}
enum TURN_OWNER {NONE, PLAYER, ENEMIES}
const _enemyScenePath: String = "E:/Godot/Projects/rpgue/assets/prefabs/enemy.tscn"
@export var _playerController: PlayerController
@export var _enemiesHBoxContainer: HBoxContainer
@export var _textBoxController: TextBoxController

var _allEnemies: Array[EnemyController]
var _playerReward: PlayerReward


func _ready() -> void:
	_setup_scene()

	Utils.set_key_action(KEY_F, GM.flowManager.open_upgrade_scene)

	var battleResult: BATTLE_RESULT = await _start_battle()

	if (battleResult == BATTLE_RESULT.WIN):
		GM.flowManager.open_upgrade_scene()
	else:
		GM.flowManager.open_upgrade_scene()

	return


#region Battle Setup

func _setup_scene() -> void:
	_spawn_enemies(4)
	_setup_player()
	_setup_UI()

	return


func _setup_player() -> void:
	_playerController.init()
	_playerReward = PlayerReward.new()

	return


func _setup_UI() -> void:
	_textBoxController.setup()

	return


func _spawn_enemies(_quantity: int) -> void:
	for i: int in _quantity:
		var enemy: Node = preload(_enemyScenePath).instantiate()
		var enemyController: EnemyController = enemy
		enemyController.init(i)

		_allEnemies.append(enemyController)
		_enemiesHBoxContainer.add_child(enemy)

	return


func _get_remaining_enemies() -> Array[EnemyController]:
	return _allEnemies.filter(func(enemy: EnemyController) -> bool: return enemy.is_alive())


#endregion


func _start_battle() -> BATTLE_RESULT:
	await _textBoxController.display_text("A wild enemy appears")
	var battleResult: BATTLE_RESULT = await _battle_turn_logic()

	return battleResult


#region Turn Logic

func _battle_turn_logic() -> BATTLE_RESULT:
	var nextToPlay: TURN_OWNER = TURN_OWNER.PLAYER
	var battleDecided: bool = false

	while (!battleDecided):
		nextToPlay = await _wait_turn_owner_action(nextToPlay)
		battleDecided = _playerController.get_player_health() < 0 || _get_remaining_enemies().size() == 0

	return BATTLE_RESULT.WIN if _playerController.get_player_health() > 0 else BATTLE_RESULT.LOSE


func _wait_turn_owner_action(nextToPlay: TURN_OWNER) -> TURN_OWNER:
	var _next_turn_owner: TURN_OWNER = TURN_OWNER.NONE

	if (nextToPlay == TURN_OWNER.PLAYER):
		print("== PLAYER TURN ==")
		var playerAction: PlayerAction = await _get_player_action()
		_execute_player_action(playerAction)
		_next_turn_owner = TURN_OWNER.ENEMIES
		print("== FINISHING PLAYER TURN ==")

	elif (nextToPlay == TURN_OWNER.ENEMIES):
		print("!! ENEMY TURN !!")
		await _execute_enemies_action()
		_next_turn_owner = TURN_OWNER.PLAYER
		print("!! FINISHING ENEMY TURN !!")

	return _next_turn_owner


func _execute_player_action(playerAction: PlayerAction) -> void:
	match (playerAction._actionCategory):
		PlayerAction.ActionCategory.DEFEND:
			_playerController.defend()

			return

		PlayerAction.ActionCategory.ATTACK:
			for enemyId: int in playerAction._enemiesIds:
				var enemy: EnemyController = _get_remaining_enemy_by_id(enemyId)
				if (!enemy.is_alive()):
					continue

				enemy.on_damage_received(_playerController.get_player_attack_damage())

			return

		PlayerAction.ActionCategory.MAGIC:
			for enemyId: int in playerAction._enemiesIds:
				var enemy: EnemyController = _get_remaining_enemy_by_id(enemyId)
				if (!enemy.is_alive()):
					continue

				enemy.on_damage_received(_playerController.get_player_magic_damage())

			return

		_:
			push_error("Invalid player action category: " + str(playerAction._actionCategory))

	push_error("Invalid player action category: " + str(playerAction._actionCategory))
	return


func _get_remaining_enemy_by_id(id: int) -> EnemyController:
	var enemies: Array[EnemyController] = _get_remaining_enemies()
	for enemy: EnemyController in enemies:
		if (enemy.enemy_id == id):
			return enemy

	push_error("Remaining enemy not found with id " + str(id))
	return null


func _get_player_action() -> PlayerAction:
	return await _playerController.start_player_turn(_get_remaining_enemies())


func _execute_enemies_action() -> void:
	for _enemy: EnemyController in _get_remaining_enemies():
		var _enemyAction: EnemyAction = _enemy.act()
		await _textBoxController.display_text(_create_enemy_action_text(_enemy, _enemyAction))
		_execute_enemy_action(_enemy, _enemyAction)

	return


func _create_enemy_action_text(_enemy: EnemyController, _enemyAction: EnemyAction) -> String:
	var _enemyInfoText: String = "Enemy n" + str(_get_remaining_enemies().find(_enemy))
	var _actionText: String
	match (_enemyAction.actionCategory as EnemyAction.EnemyActionCategory):
		EnemyAction.EnemyActionCategory.ATTACK:
			_actionText = "attacked dealing " + str(_enemyAction.actionValue) + " damage"
		EnemyAction.EnemyActionCategory.HEAL:
			_actionText = "healed itself for" + str(_enemyAction.actionValue) + " health points"
		_:
			push_error("Invalid enemy action " + str(_enemyAction.actionCategory) + " during text setup")

	return (_enemyInfoText + " " + _actionText + "!")


func _execute_enemy_action(enemy: EnemyController, enemyAction: EnemyAction) -> void:
	match (enemyAction.actionCategory):
		enemyAction.EnemyActionCategory.ATTACK:
			_playerController.damage_player(enemyAction.actionValue)

		enemyAction.EnemyActionCategory.HEAL:
			enemy.heal(enemyAction.actionValue)

	return


func _increase_player_reward(goldReward: int) -> void:
	_playerReward.increase_gold(goldReward)

	return

	#endregion
