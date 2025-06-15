class_name EnemyTurnActionState
extends BaseBattleState

var _moveToUse: BattleMove

func _init(stateMachine: BattleStateMachine, moveToUse: BattleMove) -> void:
	super(stateMachine)
	_moveToUse = moveToUse

	return


func on_state_start() -> void:
	_stateMachine.battleScene.player

	return


func on_confirm_clicked() -> void:
	print("enemy turn start battle state confirm clicked")
	_stateMachine.swap_state(CheckBattleState.new(_stateMachine, EnemyTurnEndState.new(_stateMachine)))

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
