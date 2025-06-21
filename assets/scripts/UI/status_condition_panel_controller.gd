class_name StatusConditionPanelController
extends Node

var statusConditionArray: Array
var currentItems: Dictionary


func _update_status_conditions(array: Array) -> void:
	for i: int in currentItems.size():
		var _value: StatusConditionController = currentItems[i]
		_value.queue_free()
	currentItems.clear()

	for activeStatusCondition in array:
		var _type: StatusConditionEnums.Type = activeStatusCondition.get_status_condition().get_type()
		var _statusConditionController: StatusConditionController = AssetManager.load_status_condition_controller()
		_statusConditionController.init(activeStatusCondition)

		currentItems[_type] = _statusConditionController

	return
