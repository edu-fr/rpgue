class_name BaseBattleState
extends BaseState

var stateMachine: BattleStateMachine


func _init(machine: BattleStateMachine) -> void:
	stateMachine = machine

	return


func on_attack_clicked() -> void:
	print("Base battle attack clicked")

	return


func on_tech_clicked() -> void:
	print("Base battle tech clicked")

	return


func on_attack_index_cliked(index: int) -> void:
	print("Base battle attack " + str(index) + " clicked")

	return


func on_tech_index_cliked(index: int) -> void:
	print("Base battle tech " + str(index) + " clicked")

	return

