class_name BattleMovesPanel
extends Control

@export var BattleMoveSlots: Array[Button]


func init(onBattleMoveIndexClicked: Callable, movesInfo: Array[BattleMove]) -> void:
	assert(movesInfo.size() <= 4, "Can't create more than 4 move buttons")

	for i: int in BattleMoveSlots.size():
		if (movesInfo.size() < i):
			BattleMoveSlots[i].set_visible(false)
			continue

		BattleMoveSlots[i].text = movesInfo[i]._publicName
		var actionCallable: Callable = func() -> void: onBattleMoveIndexClicked.call(i)
		BattleMoveSlots[i].pressed.connect(actionCallable)

	return


func set_buttons_enabled(value: bool) -> void:
	print("Setting moves buttons enabled: " + str(value))
	for button: Button in BattleMoveSlots:
		button.disabled = !value

	if (value == true):
		BattleMoveSlots[0].grab_focus()
	else:
		for button: Button in BattleMoveSlots:
			button.release_focus()

	return
