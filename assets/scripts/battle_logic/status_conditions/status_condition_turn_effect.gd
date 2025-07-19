class_name StatusConditionTurnEffect

var damage: float
var effectType: StatusConditionEnums.TurnEffectType


func _init(turnEffectDamage: float, turnEffectType: StatusConditionEnums.TurnEffectType) -> void:
	damage = turnEffectDamage
	effectType = turnEffectType

	return
