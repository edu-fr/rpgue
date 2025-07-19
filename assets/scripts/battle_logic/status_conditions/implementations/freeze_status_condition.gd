class_name Freeze
extends AbstractBaseStatusCondition


func get_base_damage() -> float:
	return 0


func get_type() -> StatusConditionEnums.Type:
	return StatusConditionEnums.Type.FREEZE


func pre_turn() -> StatusConditionTurnEffect:
	return StatusConditionTurnEffect.new(0, StatusConditionEnums.TurnEffectType.TURN_SKIP)


func action_phase() -> StatusConditionTurnEffect:
	return null


func post_turn() -> StatusConditionTurnEffect:
	return null
