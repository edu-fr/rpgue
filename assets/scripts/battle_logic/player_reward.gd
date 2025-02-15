class_name PlayerReward

var gold : int

func _init() -> void:
	gold = 0

	return


func increase_gold(value: int) -> void:
	gold += value

	return
