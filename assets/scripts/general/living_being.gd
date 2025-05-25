class_name LivingBeing
extends Resource

var _maxHP: float
var _currentHP: float
var _attackDamage: float
var _statusConditions: Array[AbstractBaseStatusCondition]
var _moveList: Array[BattleMove]


func _init(maxHP: float, currentHP: float, attackDamage: float, moveList: Array[BattleMove]) -> void:
	_maxHP = maxHP
	_currentHP = currentHP
	_attackDamage = attackDamage
	_statusConditions = []
	_moveList = moveList.duplicate(true)

	return


func set_status_conditions(statusConditions: Array[AbstractBaseStatusCondition]) -> void:
	_statusConditions = statusConditions

	return


func get_attack_damage() -> float:
	return _attackDamage


func get_max_HP() -> float:
	return _maxHP


func set_current_hp(newHP: float) -> void:
	if (newHP <= 0):
		_currentHP = 0
	elif (newHP >= _maxHP):
		_currentHP = _maxHP
	else:
		_currentHP = newHP

	return


func get_current_HP() -> float:
	return _currentHP


func take_damage(damage: float) -> void:
	# Apply any modifiers

	set_current_hp(get_current_HP() - damage)

	return


func get_status_condition() -> Array[AbstractBaseStatusCondition]:
	return _statusConditions


func add_status_condition(statusCondition: AbstractBaseStatusCondition) -> void:
	assert(!_statusConditions.has(statusCondition),\
	"Being already have the status condition " + Utils.get_clear_script_name(statusCondition))

	_statusConditions.append(statusCondition)

	return


func remove_status_condition(statusCondition: AbstractBaseStatusCondition) -> void:
	assert(_statusConditions.has(statusCondition),\
	"Being don't have the status condition " + Utils.get_clear_script_name(statusCondition))

	_statusConditions.erase(statusCondition)

	return


func get_moves() -> Array[BattleMove]:
	return _moveList.duplicate(true)
