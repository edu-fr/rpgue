class_name BattleScene
extends Control

const _enemyScenePath: String = "res://assets/prefabs/enemy.tscn"
@export var _playerBattleUIController: PlayerBattleUIController
@export var _enemiesHBoxContainer: HBoxContainer
@export var _textBoxController: TextBoxController
@export var _debugVisualStack: VisualStackVBoxContainer

var _stateMachine: BattleStateMachine
var _playerBattleActor: PlayerBattleActor
var _allEnemies: Array[EnemyController]
var _playerReward: PlayerReward

const enemyLimit: int = 10 # Synced with initial players ids number
var turnFlowController: TurnFlowController


func _ready() -> void:
	_stateMachine = BattleStateMachine.new(self)
	_setup_debug_visual_state_machine_stack()

	_stateMachine.push_state(BattleSetupState.new(_stateMachine))

	return


func _setup_debug_visual_state_machine_stack() -> void:
	assert(_stateMachine != null,
	"Need to instantiate the state machine before setting up the debug visual stack")

	_stateMachine.statePushed.connect(_debugVisualStack.stack)
	_stateMachine.statePop.connect(_debugVisualStack.pop)
	_stateMachine.stackPop.connect(_debugVisualStack.stack_pop)

	return


#region Battle Setup

func setup_scene() -> void: # called by SetupState
	_spawn_enemies(4)
	_setup_player()
	_setup_UI()
	_setup_turn_queue()

	return


func _setup_player() -> void:
	_playerBattleActor = GM.runManager.currentRunDataRef.get_player_battle_actor()

	assert(_playerBattleActor != null, "Can't setup battle, player battle actor is null")

	_playerBattleUIController.init(_playerBattleActor, _stateMachine)
	_playerBattleUIController.hide_and_disable_moves_panels()
	_playerBattleUIController.hide_and_disable_actions_panel()
	_playerReward = PlayerReward.new()

	return


func _setup_UI() -> void:
	_textBoxController.setup()

	return


func _spawn_enemies(_quantity: int) -> void:
	@warning_ignore_start("unsafe_property_access", "unsafe_method_access")
	var _enemyData: EnemyData = GM.dataManager.get_random_enemy() # TODO: Select by habitat
	@warning_ignore_restore("unsafe_property_access", "unsafe_method_access")

	for i: int in _quantity:
		var enemy: Node = preload(_enemyScenePath).instantiate()
		var enemyController: EnemyController = enemy
		enemyController.init(EnemyBattleActor.new(i, _enemyData.maxHP, _enemyData.maxHP, _enemyData.baseDamageMultiplier, _enemyData.moveNameList))

		_allEnemies.append(enemyController)
		_enemiesHBoxContainer.add_child(enemy)

	return


# Should always be called AFTER spawning player and enemies
func _setup_turn_queue() -> void:
	var _playerIds: Array[int] = []
	_playerIds.append(_playerBattleActor.get_id())
	var _enemyIds: Array[int] = []
	for _enemy: EnemyController in _allEnemies:
		_enemyIds.append(_enemy.get_id())

	turnFlowController = TurnFlowController.new(_playerIds, _enemyIds)

	return


#endregion

#region Battle Result Check

func get_next_turn_owner_id() -> int:
	var _remainingPlayersIds: Array[int] = _get_remaining_players_ids()
	var _remainingEnemiesIds: Array[int] = _get_remaining_enemies_ids()

	if (_remainingEnemiesIds.size() == 0):
		push_error("Not enough enemies left to get next turn owner")
	if (_remainingPlayersIds.size() == 0):
		push_error("Not enough players left to get next turn owner")

	return turnFlowController.get_next_turn(_remainingPlayersIds, _remainingEnemiesIds)


# called by battle state machine living checks
func get_battle_result() -> BattleEnums.BattleResult:
	if (!_is_player_alive()):
		return BattleEnums.BattleResult.PLAYER_LOSE

	if (_get_remaining_enemies().size() == 0):
		return BattleEnums.BattleResult.PLAYER_WIN

	return BattleEnums.BattleResult.ONGOING


func _get_remaining_players_ids() -> Array[int]:
	var _idArray: Array[int] = []
	if (_playerBattleActor.alive()):
		_idArray.append(_playerBattleActor.get_id())

	return _idArray


func _get_remaining_enemies_ids() -> Array[int]:
	var _idArray: Array[int] = []
	for _enemyController: EnemyController in _get_remaining_enemies():
		_idArray.append(_enemyController.get_id())

	return _idArray


func _get_remaining_enemies() -> Array[EnemyController]:
	return _allEnemies.filter(func(enemy: EnemyController) -> bool: return enemy.is_alive())


func _is_player_alive() -> bool:
	return _playerBattleUIController.is_player_alive()


func get_enemy_controller_by_id(id: int) -> EnemyController:
	for enemy: EnemyController in _get_remaining_enemies():
		if enemy.get_id() == id:
			return enemy

	push_error("Remaining enemy controller not found with id " + str(id))
	return null


func get_player_instance() -> PlayerBattleActor:
	return _playerBattleActor


func _apply_attack_on_player(battle_move: BattleMove) -> void:
	_playerBattleActor.take_damage(battle_move.power)

	return


#region Turn Logic

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_left")):
		_stateMachine.on_left_arrow_clicked()
	elif (event.is_action_pressed("ui_right")):
		_stateMachine.on_right_arrow_clicked()
	elif (event.is_action_pressed("ui_down")):
		_stateMachine.on_down_arrow_clicked()
	elif (event.is_action_pressed("ui_up")):
		_stateMachine.on_up_arrow_clicked()
	elif (event.is_action_pressed("ui_accept")):
		_stateMachine.on_confirm_clicked()
	elif (event.is_action_pressed("ui_cancel")):
		_stateMachine.on_back_clicked()

	return


func _get_remaining_enemy_by_id(id: int) -> EnemyController:
	var enemies: Array[EnemyController] = _get_remaining_enemies()
	for enemy: EnemyController in enemies:
		if (enemy.get_id() == id):
			return enemy

	push_error("Remaining enemy not found with id " + str(id))
	return null


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


func _increase_player_reward(goldReward: int) -> void:
	_playerReward.increase_gold(goldReward)

	return

	#endregion