class_name BattleScene
extends Control

enum BattleResult {NONE, ONGOING, PLAYER_WIN, PLAYER_LOSE }
enum TurnOwner {NONE, PLAYER, ENEMIES}
const _enemyScenePath: String = "res://assets/prefabs/enemy.tscn"
@export var _playerBattleUIController: PlayerBattleUIController
@export var _enemiesHBoxContainer: HBoxContainer
@export var _textBoxController: TextBoxController
@export var _debugVisualStack: VisualStackVBoxContainer

var _stateMachine: BattleStateMachine
var _allEnemies: Array[EnemyController]
var _playerReward: PlayerReward


func _ready() -> void:
	_stateMachine = BattleStateMachine.new(self)
	_setup_debug_visual_state_machine_stack()

	_stateMachine.push_state(BattleSetupState.new(_stateMachine)) ## PAREI AQUI

	var battleResult: BattleResult = await _start_battle()

	if (battleResult == BattleResult.PLAYER_WIN):
		GM.flowManager.open_upgrade_scene()
	else:
		GM.flowManager.open_upgrade_scene()

	return


func _setup_debug_visual_state_machine_stack() -> void:
	assert(_stateMachine != null,
	"Need to instantiate the state machine before setting up the debug visual stack")

	_stateMachine.statePushed.connect(_debugVisualStack.stack)
	_stateMachine.statePop.connect(_debugVisualStack.pop)
	_stateMachine.stackPop.connect(_debugVisualStack.stack_pop)

	return


#region Battle Setup
# called by SetupState

func setup_scene() -> void:
	_spawn_enemies(4)
	_setup_player()
	_setup_UI()

	return


func _setup_player() -> void:
	_playerBattleUIController.init(_stateMachine)
	_playerBattleUIController.hide_and_disable_moves_panels()
	_playerBattleUIController.hide_and_disable_actions_panel()
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


#endregion

#region Battle Result Check
# called by check battle end state
func get_battle_result() -> BattleResult:
	if (!_is_player_alive()):
		return BattleResult.PLAYER_LOSE

	if (_get_remaining_enemies().size() == 0):
		return BattleResult.PLAYER_WIN

	return BattleResult.ONGOING


func _get_remaining_enemies() -> Array[EnemyController]:
	return _allEnemies.filter(func(enemy: EnemyController) -> bool: return enemy.is_alive())


func _is_player_alive() -> bool:
	return _playerBattleUIController.is_player_alive()


func _start_battle() -> BattleResult:
	await _textBoxController.display_text("A wild enemy appears")
	var battleResult: BattleResult = await _battle_turn_logic()

	return battleResult


#region Turn Logic

func _battle_turn_logic() -> BattleResult:
	var nextToPlay: TurnOwner = TurnOwner.PLAYER
	var battleDecided: bool = false

	while (!battleDecided):
		nextToPlay = await _wait_turn_owner_action(nextToPlay)
		battleDecided = _playerBattleUIController.get_player_health() < 0 || _get_remaining_enemies().size() == 0

	return BattleResult.PLAYER_WIN if _playerBattleUIController.get_player_health() > 0 else BattleResult.PLAYER_LOSE


func _wait_turn_owner_action(nextToPlay: TurnOwner) -> TurnOwner:
	var _next_turn_owner: TurnOwner = TurnOwner.NONE

	if (nextToPlay == TurnOwner.PLAYER):
		print("== PLAYER TURN ==")
		var playerAction: PlayerAction = await _get_player_action()
		_execute_player_action(playerAction)
		_next_turn_owner = TurnOwner.ENEMIES
		print("== FINISHING PLAYER TURN ==")

	elif (nextToPlay == TurnOwner.ENEMIES):
		print("!! ENEMY TURN !!")
		await _execute_enemies_action()
		_next_turn_owner = TurnOwner.PLAYER
		print("!! FINISHING ENEMY TURN !!")

	return _next_turn_owner


func _execute_player_action(playerAction: PlayerAction) -> void:
	match (playerAction._actionCategory):
		PlayerAction.ActionCategory.ATTACK:
			for enemyId: int in playerAction._enemiesIds:
				var enemy: EnemyController = _get_remaining_enemy_by_id(enemyId)
				if (!enemy.is_alive()):
					continue

				enemy.receive_player_attack(10)

			return

		PlayerAction.ActionCategory.TECH:
			for enemyId: int in playerAction._enemiesIds:
				var enemy: EnemyController = _get_remaining_enemy_by_id(enemyId)
				if (!enemy.is_alive()):
					continue

				enemy.receive_player_attack(10)

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
	return await _playerBattleUIController.start_player_turn(_get_remaining_enemies())


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
			_playerBattleUIController.damage_player(enemyAction.actionValue)

		enemyAction.EnemyActionCategory.HEAL:
			enemy.heal(enemyAction.actionValue)

	return


func _increase_player_reward(goldReward: int) -> void:
	_playerReward.increase_gold(goldReward)

	return

	#endregion
