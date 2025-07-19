class_name EnemyTurnActionState
extends BaseBattleState

var _enemyInstance: EnemyBattleActor
var _moveToUse: BattleMove

func _init(moveToUse: BattleMove, enemyInstance: EnemyBattleActor, stateMachine: BattleStateMachine,) -> void:
	super(stateMachine)
	_enemyInstance = enemyInstance
	_moveToUse = moveToUse

	return


func on_state_start() -> void:
	# Attack modifiers probably gonna show up here and be used after this (or maybe the turn will be skipped)
	_enemyInstance.activate_action_phase_start_effects()

	if (_change_state_if_battle_ended()):
		return

	if (skipping_turn_as_enemy_is_not_alive(_enemyInstance)):
		return

	if (GM.verbose):
		print("[ENEMY] Move to use: ")
		print(_moveToUse)

	var _outgoingBattleMove: OutgoingBattleMove = _moveToUse.get_use_result(_stateMachine.battleScene.get_player())
	_stateMachine.battleScene._apply_attack_on_player(_outgoingBattleMove)

	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, EnemyTurnPostTurnState.new(_enemyInstance, _stateMachine)))

	return