class_name ActiveStatusCondition

var _caster: BattleActor
var _target: BattleActor
var _statusCondition: AbstractBaseStatusCondition
var _baseAmount: int
var _remainingAmount: int


func _init(caster: BattleActor, target: BattleActor, statusCondition: AbstractBaseStatusCondition, amount: int) -> void:
	assert(caster != null, "Null caster in ActiveStatusCondition")
	assert(target != null, "Null target in ActiveStatusCondition")
	assert(statusCondition != null, "Null status condition in ActiveStatusCondition")

	_caster = caster
	_target = target
	_statusCondition = statusCondition

	# TODO: Apply player/enemy multiplyers here?

	_baseAmount = amount
	_remainingAmount = amount

	return


func get_status_condition() -> AbstractBaseStatusCondition:
	return _statusCondition


func get_remaining_amount() -> int:
	return _remainingAmount


func update_status_condition(statusConditionUpdate: ActiveStatusCondition) -> void:
	_remainingAmount += statusConditionUpdate._remainingAmount

	return


func on_turn_finished() -> void:
	_remainingAmount -= 1

	return