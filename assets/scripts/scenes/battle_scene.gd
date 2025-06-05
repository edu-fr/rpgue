class_name BattleScene
extends Control

enum BattleResult { UNKNOWN, NONE, ONGOING, PLAYER_WIN, PLAYER_LOSE }
enum TurnOwner { UNKNOWN, NONE, PLAYER, ENEMIES}
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
		if (enemy.enemy_id == id):
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
