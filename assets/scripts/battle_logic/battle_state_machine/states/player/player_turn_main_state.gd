class_name PlayerTurnMainState
extends BaseBattleState

var _playerBattleActor: PlayerBattleActor
var _currentlySelectedMoves: Array[SelectedBattleMove]


func _init(playerBattleActor: PlayerBattleActor, currentlySelectedMoves: Array[SelectedBattleMove], stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor
	_currentlySelectedMoves = currentlySelectedMoves

	return


func on_state_start() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.show_and_enable_actions_panel()

	return


func on_state_resumed() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.show_and_enable_actions_panel()

	return


func on_state_end() -> void:
	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.hide_and_disable_actions_panel()

	return


func on_attack_clicked() -> void:
	_stateMachine.push_state(PlayerSelectMoveState.new(_playerBattleActor, _currentlySelectedMoves, _stateMachine))

	return

