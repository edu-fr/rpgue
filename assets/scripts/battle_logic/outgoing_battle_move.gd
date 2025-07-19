class_name OutgoingBattleMove

var rawDamageToDeal: float
var damageTypes: Array[ImportUtils.MoveType]
var statusConditionsToApply: Array[ActiveStatusCondition]
var doApplyStatusCondition: bool


func _init(damage: float, types: Array[ImportUtils.MoveType], statusConditions: Array[ActiveStatusCondition], statusConditionsApplySuccess: bool) -> void:
	rawDamageToDeal = damage
	damageTypes = types.duplicate(true)
	statusConditionsToApply = statusConditions
	doApplyStatusCondition = statusConditionsApplySuccess

	return
