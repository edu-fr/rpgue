class_name StatusConditionPanelController
extends GridContainer

var currentStatusConditions: Dictionary


func update_status_conditions(updatedStatusConditions: Array[ActiveStatusCondition]) -> void:
	_update_or_remove_existing_ones(updatedStatusConditions)

	for activeStatusCondition: ActiveStatusCondition in updatedStatusConditions:
		if !currentStatusConditions.has(activeStatusCondition.get_status_condition().get_type()):
			_insert_new_status_condition(activeStatusCondition)

	return


func _update_or_remove_existing_ones(updatedStatusConditions: Array[ActiveStatusCondition]) -> void:
	var statusConditionControllersToRemove: Array[StatusConditionController] = []

	for statusConditionController: StatusConditionController in currentStatusConditions.values():
		if !updatedStatusConditions.has(statusConditionController.get_active_status_condition()):
			statusConditionControllersToRemove.append(statusConditionController)
			continue

		statusConditionController.setup_duration_text(statusConditionController.get_active_status_condition().get_remaining_amount())

	for statusConditionController: StatusConditionController in statusConditionControllersToRemove:
		currentStatusConditions.erase(statusConditionController.get_active_status_condition().get_status_condition().get_type())
		statusConditionController.queue_free()
		self.remove_child(statusConditionController)

	return


func _insert_new_status_condition(activeStatusCondition: ActiveStatusCondition) -> void:
	assert(!currentStatusConditions.has(activeStatusCondition.get_status_condition().get_type()), "Trying to insert status condition that already exists")

	var _statusConditionController: StatusConditionController = AssetManager.load_status_condition_controller()
	_statusConditionController.init(activeStatusCondition)
	self.add_child(_statusConditionController)
	var _type: StatusConditionEnums.Type = activeStatusCondition.get_status_condition().get_type()
	currentStatusConditions[_type] = _statusConditionController

	return


func clear_status_conditions() -> void:
	for statusConditionController: StatusConditionController in currentStatusConditions.values():
		statusConditionController.queue_free()
		self.remove_child(statusConditionController)

	currentStatusConditions.clear()

	return


func hide_panel() -> void:
	self.visible = false

	return
