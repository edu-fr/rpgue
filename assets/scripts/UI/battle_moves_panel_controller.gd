class_name BattleMovesPanel
extends Control

@export var battleMoveButtonsSlots: Array[Button] ## Already initialized externally

var battleMovesList: Array[BattleMove]


func init(onBattleMoveIndexClicked: Callable, movesInfo: Array[BattleMove]) -> void:
	assert(movesInfo.size() <= 4, "Can't create more than 4 move buttons")

	if(movesInfo.size() == 0):
		hide()
		return

	battleMovesList = []

	for i: int in battleMoveButtonsSlots.size():
		if (movesInfo.size() <= i):
			battleMoveButtonsSlots[i].set_visible(false)
			continue

		battleMovesList.append(movesInfo[i])
		battleMoveButtonsSlots[i].text = movesInfo[i].publicName
		var actionCallable: Callable = func() -> void: onBattleMoveIndexClicked.call(i)
		battleMoveButtonsSlots[i].button_up.connect(actionCallable)

	return


func set_buttons_enabled(value: bool) -> void:
	for button: Button in battleMoveButtonsSlots:
		button.disabled = !value

	if (value == true):
		battleMoveButtonsSlots[0].grab_focus()
	else:
		for button: Button in battleMoveButtonsSlots:
			button.release_focus()

	return
