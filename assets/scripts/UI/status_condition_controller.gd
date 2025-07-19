class_name StatusConditionController
extends TextureRect

@export var _durationText: RichTextLabel

var _activeStatusCondition: ActiveStatusCondition


func init(activeStatusCondition: ActiveStatusCondition) -> void:
	_activeStatusCondition = activeStatusCondition
	setup_icon(_activeStatusCondition.get_status_condition().get_type())
	setup_duration_text(_activeStatusCondition._remainingAmount)
	return


func setup_icon(statusConditionType: StatusConditionEnums.Type) -> void:
	assert(statusConditionType != null, "Trying to setup status condition icon without initializing it")
	self.texture = AssetManager.load_status_condition_icon(statusConditionType)

	return


func setup_duration_text(remainingDuration: int) -> void:
	_durationText.text = str(remainingDuration)

	return
