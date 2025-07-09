class_name PlayerTurnMainState
extends BaseBattleState

var _playerBattleActor: PlayerBattleActor


func _init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor

	return


func on_state_start() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.show_and_enable_actions_panel()


func on_state_resumed() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.show_and_enable_actions_panel()


func on_state_end() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.hide_and_disable_actions_panel()


func on_attack_clicked() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.hide_and_disable_actions_panel()

	_stateMachine.push_state(PlayerSelectMoveState.new(ImportUtils.Category.ATTACK, _playerBattleActor, _stateMachine))

	return


func on_tech_clicked() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.hide_and_disable_actions_panel()

	_stateMachine.push_state(PlayerSelectMoveState.new(ImportUtils.Category.TECH, _playerBattleActor, _stateMachine))

	return
