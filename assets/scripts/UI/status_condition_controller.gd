class_name StatusConditionController
extends PanelContainer

@export var _icon: TextureRect
@export var _durationText: RichTextLabel

var _activeStatusCondition: ActiveStatusCondition

func init(activeStatusCondition: ActiveStatusCondition) -> void:
	_activeStatusCondition = activeStatusCondition
	setup_icon(_activeStatusCondition.get_status_condition().get_type())
	setup_duration_text(_activeStatusCondition.get_remaining_amount())
	return


func setup_icon(statusConditionType: StatusConditionEnums.Type) -> void:
	assert(statusConditionType != null, "Trying to setup status condition icon without initializing it")
	_icon.texture = AssetManager.load_status_condition_icon(statusConditionType)

	return


func setup_duration_text(remainingDuration: int) -> void:
	_durationText.text = str(remainingDuration)

	return


func get_active_status_condition() -> ActiveStatusCondition:
	return _activeStatusCondition