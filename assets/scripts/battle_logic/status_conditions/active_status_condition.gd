class_name ActiveStatusCondition

var _caster: BattleActor
var _target: BattleActor
var _statusCondition: AbstractBaseStatusCondition
var _baseDuration: int
var _remainingDuration: int

func _init(caster: BattleActor, target: BattleActor, statusCondition: AbstractBaseStatusCondition, duration: int) -> void:
	_caster = caster
	_target = target
	_statusCondition = statusCondition

	# TODO: Apply player/enemy multiplyers here?

	_baseDuration = duration
	_remainingDuration = duration

	return


func get_status_condition() -> AbstractBaseStatusCondition:
	return _statusCondition
