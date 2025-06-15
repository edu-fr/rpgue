class_name EnemyTurnStartState
extends BaseBattleState

var _enemyInstance: EnemyInstance
var _moveToUse: BattleMove


func _init(enemyInstance: EnemyInstance, stateMachine: BattleStateMachine) -> void:
	super(stateMachine)
	_enemyInstance = enemyInstance

	return


func on_state_start() -> void:
	_enemyInstance.activate_pre_turn_start_effects()

	if (_check_battle_ended()):
		return

	_moveToUse = _enemyInstance.get_random_move()

	return


func on_confirm_clicked() -> void:
	print("enemy turn start battle state confirm clicked")
	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, EnemyTurnActionState.new(_stateMachine, _moveToUse)))

	return


func on_attack_clicked() -> void:
	print("enemy turn start battle state attack clicked")

	return


func on_tech_clicked() -> void:
	print("enemy turn start battle state tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("enemy turn start battle state attack index " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("enemy turn start battle state tech index " + str(index) + " clicked")

	return
