class_name LivingBeing
extends Resource

signal current_hp_changed(oldHP: float, newHp: float, animate: bool)
signal max_hp_changed(oldMaxHP: float, newMaxHP: float, animate: bool)

var _id: int
var _maxHP: float
var _currentHP: float
var _attackDamageMultiplier: float
var _statusConditions: Array[AbstractBaseStatusCondition]
var _moveList: Array[BattleMove]


func _init(id: int, maxHP: float, currentHP: float, attackDamageMultiplier: float, moveList: Array[BattleMove]) -> void:
	_id = id
	_maxHP = maxHP
	_currentHP = currentHP
	_attackDamageMultiplier = attackDamageMultiplier
	_statusConditions = []
	_moveList = moveList.duplicate(true)

	return


func set_status_conditions(statusConditions: Array[AbstractBaseStatusCondition]) -> void:
	_statusConditions = statusConditions

	return


func get_attack_damage_multiplier() -> float:
	return _attackDamageMultiplier


func get_max_HP() -> float:
	return _maxHP


func set_current_hp(newHP: float, animate: bool) -> void:
	var oldHP: float = _currentHP

	if (newHP <= 0):
		_currentHP = 0
	elif (newHP >= _maxHP):
		_currentHP = _maxHP
	else:
		_currentHP = newHP

	current_hp_changed.emit(oldHP, _currentHP, animate)
	return


func get_current_HP() -> float:
	return _currentHP


func set_max_hp(newMaxHP: float, animate: bool) -> void:
	var oldMaxHP: float = _maxHP

	if (newMaxHP <= 1):
		_maxHP = 1
	elif (newMaxHP > _maxHP):
		_maxHP = newMaxHP
	else:
		return

	max_hp_changed.emit(oldMaxHP, _maxHP, animate)

	return


func take_damage(damage: float) -> void:
	# Apply any modifiers

	set_current_hp(get_current_HP() - damage, true)

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


func get_random_move() -> BattleMove:
	assert(_moveList.size() != 0, "Can't get a random move because the move list is empty")

	return _moveList[randi() % _moveList.size()]


func activate_pre_turn_start_effects() -> void:
	for _statusCondition: AbstractBaseStatusCondition in _statusConditions:
		_statusCondition.pre_turn()
		if (!alive()):
			return

	return


func activate_action_phase_start_effects() -> void:
	for _statusCondition: AbstractBaseStatusCondition in _statusConditions:
		_statusCondition.action_phase()
		if (!alive()):
			return

	return


func activate_post_turn_start_effects() -> void:
	for _statusCondition: AbstractBaseStatusCondition in _statusConditions:
		_statusCondition.post_turn()
		if (!alive()):
			return

	return


func alive() -> bool:
	return get_current_HP() > 0


func get_id() -> int:
	return _id