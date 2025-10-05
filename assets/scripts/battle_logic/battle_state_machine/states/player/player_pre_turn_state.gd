class_name PlayerPreTurnState
extends BaseBattleState

var _playerBattleActor: PlayerBattleActor

func _init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_playerBattleActor = playerBattleActor

	return


func on_state_start() -> void:
	_playerBattleActor.activate_pre_turn_start_effects()

	if (_change_state_if_battle_ended()):
		return

	var playerController: PlayerBattleUIController = _stateMachine.battleScene._playerBattleUIController
	playerController.update_action_slots_for_turn()

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, PlayerTurnMainState.new(_playerBattleActor, [], _stateMachine)))

	return
