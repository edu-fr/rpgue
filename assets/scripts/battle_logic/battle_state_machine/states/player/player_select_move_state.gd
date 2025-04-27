class_name PlayerSelectMoveState
extends BaseBattleState

var _category: MoveData.Category


func _init(category: MoveData.Category, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_category = category

	return


func on_state_start() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.show_and_enable_selected_moves_panel(_category)

	return


func on_state_resumed() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.show_and_enable_selected_moves_panel(_category)

	return


func on_state_end() -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	_battleUI.hide_and_disable_moves_panels()

	return


func on_attack_index_cliked(index: int) -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	var _batteMove: BattleMove = _battleUI._attackMovesPanel.battleMovesList[index]
	_battleUI.hide_and_disable_moves_panels()
	_stateMachine.push_state(PlayerSelectTargetState.new(_batteMove, _stateMachine))

	return


func on_tech_index_cliked(index: int) -> void:
	var _battleUI: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	var _batteMove: BattleMove = _battleUI._techMovesPanel.battleMovesList[index]
	_battleUI.hide_and_disable_moves_panels()
	_stateMachine.push_state(PlayerSelectTargetState.new(_batteMove, _stateMachine))

	return


func on_back_clicked() -> void:
	print("player select move battle state back clicked")
	_stateMachine.pop_state()

	return

