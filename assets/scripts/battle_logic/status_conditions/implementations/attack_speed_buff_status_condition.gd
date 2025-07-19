class_name AttackSpeedBuff
extends AbstractBaseStatusCondition


func get_base_damage() -> float:
	return 0


func get_type() -> StatusConditionEnums.Type:
	return StatusConditionEnums.Type.ATTACK_SPEED_BUFF


func pre_turn() -> StatusConditionTurnEffect:
	return null


func action_phase() -> StatusConditionTurnEffect:
	return null


func post_turn() -> StatusConditionTurnEffect:
	return null
