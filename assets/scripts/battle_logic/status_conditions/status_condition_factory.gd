class_name StatusConditionFactory


static func create_status_condition(statusConditionType: StatusConditionEnums.Type) -> AbstractBaseStatusCondition:
	match statusConditionType:
		StatusConditionEnums.Type.POISON: return PoisonStatusCondition.new()
		StatusConditionEnums.Type.BURN: return Burn.new()
		StatusConditionEnums.Type.FREEZE: return Freeze.new()
		StatusConditionEnums.Type.STAGGER: return Stagger.new()
		StatusConditionEnums.Type.ATTACK_POWER_BUFF: return AttackPowerBuff.new()
		StatusConditionEnums.Type.ATTACK_SPEED_BUFF: return AttackSpeedBuff.new()
		StatusConditionEnums.Type.DEFENSE: return DefenseBuff.new()
		_: push_error("Status condition not found on factory")

	return