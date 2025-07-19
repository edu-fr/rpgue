class_name Burn
extends AbstractBaseStatusCondition


func get_base_damage() -> float:
	return 10


func get_type() -> StatusConditionEnums.Type:
	return StatusConditionEnums.Type.BURN


func pre_turn() -> StatusConditionTurnEffect:
	return null


func action_phase() -> StatusConditionTurnEffect:
	return null


func post_turn() -> StatusConditionTurnEffect:
	return StatusConditionTurnEffect.new(get_base_damage(), StatusConditionEnums.TurnEffectType.DAMAGE)
