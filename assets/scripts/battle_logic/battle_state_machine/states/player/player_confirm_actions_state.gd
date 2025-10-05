class_name PlayerConfirmActionsState
extends BaseBattleState

var _selectedBattleMoves: Array[SelectedBattleMove]
var _playerBattleActor: PlayerBattleActor


func _init(selectedBattleMoves: Array[SelectedBattleMove], playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor
	_selectedBattleMoves = selectedBattleMoves

	return


func on_state_start() -> void:
	_stateMachine.battleScene._playerBattleUIController.show_and_enable_confirm_actions_button()

	return


func on_state_end() -> void:
	_stateMachine.battleScene._playerBattleUIController.hide_and_disable_confirm_actions_button()

	return


func on_confirm_clicked() -> void:
	_stateMachine.pop_stack(PlayerAttackResultState.new(_selectedBattleMoves, _playerBattleActor, _stateMachine))

	return
