class_name BattleMovesPanel
extends Control

@export var BattleMoveSlots: Array[Button]

func _init(movesInfo: Array[BattleMove]) -> void:
	assert(movesInfo.size() <= 4, "Can't create more than 4 move buttons")

	
	for i: int in BattleMoveSlots.size():
		if (movesInfo.size() < i):
			BattleMoveSlots[i].set_visible(false)
			continue

		BattleMoveSlots[i].text = "Move " + str(i)


	return