class_name BattleStateMachine extends BaseStateMachine

var battleScene: BattleScene

func _init(scene: BattleScene) -> void:
	super() # Super() initialize the stack

	battleScene = scene

	return



func on_attack_clicked() -> void:
	currentState.on_attack_clicked()

	return


func on_tech_clicked() -> void:
	currentState.on_tech_clicked()

	return


func on_attack_index_cliked(index: int) -> void:
	currentState.on_attack_index_cliked(index)

	return


func on_tech_index_cliked(index: int) -> void:
	currentState.on_tech_index_cliked(index)

	return
