class_name Stagger
extends AbstractBaseStatusCondition


func get_base_damage() -> float:
	return 0.25


func get_type() -> StatusConditionEnums.Type:
	return StatusConditionEnums.Type.STAGGER


func pre_turn() -> StatusConditionTurnEffect:
	return null


func action_phase() -> StatusConditionTurnEffect:
	return StatusConditionTurnEffect.new(get_base_damage(), StatusConditionEnums.TurnEffectType.MISS_CHANCE)


func post_turn() -> StatusConditionTurnEffect:
	return null
