class_name Poison
extends AbstractBaseStatusCondition

func get_type() -> StatusConditionEnums.Type:
	return StatusConditionEnums.Type.POISON


func pre_turn() -> StatusConditionTurnEffect:
	return null


func action_phase() -> StatusConditionTurnEffect:
	return null


func post_turn() -> StatusConditionTurnEffect:
	return StatusConditionTurnEffect.new(10, TurnEffectType.DAMAGE)
