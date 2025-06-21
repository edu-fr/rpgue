class_name AbstractBaseStatusCondition

var _baseDamage: int
var _caster: BattleActor
var _target: BattleActor


func _init(caster: BattleActor, target: BattleActor, baseDamage: int) -> void:
	_caster = caster
	_target = target
	_baseDamage = baseDamage

	return


func get_type() -> StatusConditionEnums.Type:
	push_error("status condition type not override on child")

	return StatusConditionEnums.Type.UNKNOWN


func pre_turn() -> StatusConditionTurnEffect:
	push_error("status condition pre turn not implemented on child")

	return null


func action_phase() -> StatusConditionTurnEffect:
	push_error("status condition action phase not implemented on child")

	return null


func post_turn() -> StatusConditionTurnEffect:
	push_error("status condition post turn not implemented on child")

	return null