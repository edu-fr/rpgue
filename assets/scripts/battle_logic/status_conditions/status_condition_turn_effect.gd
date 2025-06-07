class_name StatusConditionTurnEffect

var _damage: int
var _turnEffectType: StatusConditionEnums.TurnEffectType


func _init(damage: int, turnEffectType: StatusConditionEnums.TurnEffectType) -> void:
	_damage = damage
	_turnEffectType = turnEffectType

	return
