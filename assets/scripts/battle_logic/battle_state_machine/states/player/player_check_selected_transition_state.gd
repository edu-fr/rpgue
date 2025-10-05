class_name PlayerCheckSelectedTransitionState
extends BaseBattleState

var _selectedBattleMoves: Array[SelectedBattleMove]
var _playerBattleActor: PlayerBattleActor

func _init(selectedBattleMoves: Array[SelectedBattleMove], playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_selectedBattleMoves = selectedBattleMoves
	_playerBattleActor = playerBattleActor

	return

func on_state_start() -> void:
	if (_selectedBattleMoves.size() < _playerBattleActor.actionSlots):
		_stateMachine.push_state(PlayerTurnMainState.new(_playerBattleActor, _selectedBattleMoves, _stateMachine))
	else:
		_stateMachine.push_state(PlayerConfirmActionsState.new(_selectedBattleMoves, _playerBattleActor, _stateMachine))

	return
