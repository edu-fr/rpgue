class_name PlayerSelectMoveState
extends BaseBattleState

var _playerBattleActor: PlayerBattleActor
var _currentlySelectedMoves: Array[SelectedBattleMove]


func _init(playerBattleActor: PlayerBattleActor, currentlySelectedMoves: Array[SelectedBattleMove], stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor
	_currentlySelectedMoves = currentlySelectedMoves

	return


func on_state_start() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.show_and_enable_moves_panel()

	return


func on_state_resumed() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.show_and_enable_moves_panel()

	return


func on_state_end() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.hide_and_disable_moves_panels()

	return


func on_attack_index_cliked(index: int) -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	var _batteMove: BattleMove = _battleUI._movesPanel.battleMovesList[index]
	_battleUI.hide_and_disable_moves_panels()
	_stateMachine.push_state(PlayerSelectTargetState.new(_batteMove, _playerBattleActor, _currentlySelectedMoves, _stateMachine))

	return


func on_back_clicked() -> void:
	print("player select move battle state back clicked")
	_stateMachine.pop_state()

	return

