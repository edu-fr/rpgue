class_name ActionSlotsController
extends Control

@export var actionSlotControllers: Array[ActionSlotController]


func init() -> void:
	for actionSlotController: ActionSlotController in actionSlotControllers:
		actionSlotController.set_visible(false)

	return


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


func on_move_selected(battle_move: BattleMove, index: int) -> void:
	assert(actionSlotControllers.size() > index, "ActionSlotsController: Index out of range on move selected")

	actionSlotControllers[index].add_move(battle_move)

	return


func on_move_selection_canceled(index: int) -> void:
	assert(actionSlotControllers.size() > index, "ActionSlotsController: Index out of range on move selected")

	actionSlotControllers[index].remove_move()

	return
