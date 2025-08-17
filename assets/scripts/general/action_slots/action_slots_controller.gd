class_name ActionSlotsController
extends Control

@export var actionSlotControllers: Array[ActionSlotController]


func turn_setup(_playerBattleActor: PlayerBattleActor) -> void:
	for i: int in range(actionSlotControllers.size()):
		if (i > _playerBattleActor.actionSlots):
			actionSlotControllers[i].set_visible(false)
			continue

		_draw_action_slot(i)


	return


func _draw_action_slot(index: int) -> void:
	var type: Action.ActionSlotType = Action.ActionSlotType.values()[GM.rng.randi_range(0, 4)]
	actionSlotControllers[index].setup(type)
	actionSlotControllers[index].set_active(true)

	return
