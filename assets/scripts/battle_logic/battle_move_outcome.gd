class_name BattleMoveOutcome

var damageDealt: float
var damageTypesApplied: Array[ImportUtils.MoveType]
var statusConditionsApplied: Array[StatusConditionEnums.Type]


func _init(damage: float, types: Array[ImportUtils.MoveType], statusConditionsSuccessfullyApplied: Array[StatusConditionEnums.Type]) -> void:
	damageDealt = damage
	damageTypesApplied = types.duplicate(true)
	statusConditionsApplied = statusConditionsSuccessfullyApplied.duplicate(true)

	return
