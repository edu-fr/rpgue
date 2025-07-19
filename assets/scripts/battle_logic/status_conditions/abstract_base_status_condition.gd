class_name AbstractBaseStatusCondition

func get_base_damage() -> float:
	push_error("base damage not override on child")

	return -1


func get_type() -> StatusConditionEnums.Type:
	push_error("status condition type not override on child")

	return StatusConditionEnums.Type.UNKNOWN


func pre_turn() -> StatusConditionTurnEffect:
	push_error("status condition pre turn not implemented on child")

	return null


func action_phase() -> StatusConditionTurnEffect:
	push_error("status condition action phase not implemented on child")

	return null


func post_turn() -> StatusConditionTurnEffect:
	push_error("status condition post turn not implemented on child")

	return null