class_name BattleActor # WONT PERSIST ON MEMORY

signal current_hp_changed(oldHP: float, newHp: float, animate: bool)
signal max_hp_changed(oldMaxHP: float, newMaxHP: float, animate: bool)

var _id: int
var _maxHP: float
var _initialHP: float
var _currentHP: float
var _attackDamageMultiplier: float
var _statusConditions: Array[ActiveStatusCondition]
var _battleMoveList: Array[BattleMove]


func _init(id: int, maxHP: float, initialHP: float, attackDamageMultiplier: float, moveNames: Array[String]) -> void:
	_id = id
	_maxHP = maxHP
	_initialHP = initialHP
	_currentHP = initialHP
	_attackDamageMultiplier = attackDamageMultiplier
	_statusConditions = []
	_battleMoveList = GM.dataManager.create_battle_moves_from_move_names(moveNames, self)

	return


func get_id() -> int:
	return _id


func get_attack_damage_multiplier() -> float:
	return _attackDamageMultiplier


func get_max_HP() -> float:
	return _maxHP


func set_current_hp(newHP: float, animate: bool) -> void:
	var _oldHP: float = _currentHP

	if (newHP <= 0):
		_currentHP = 0
	elif (newHP >= _maxHP):
		_currentHP = _maxHP
	else:
		_currentHP = newHP

	current_hp_changed.emit(_oldHP, _currentHP, animate)
	return


func get_current_HP() -> float:
	return _currentHP


func set_max_hp(newMaxHP: float, animate: bool) -> void:
	var _oldMaxHP: float = _maxHP

	if (newMaxHP <= 1):
		_maxHP = 1
	elif (newMaxHP > _maxHP):
		_maxHP = newMaxHP
	else:
		return

	max_hp_changed.emit(_oldMaxHP, _maxHP, animate)

	return


func take_battle_move(opponentOutgoingBattleMove: OutgoingBattleMove) -> BattleMoveOutcome:
	var damageReceived: float = opponentOutgoingBattleMove.rawDamageToDeal
	_take_damage(damageReceived)
	_try_apply_status_conditions(opponentOutgoingBattleMove)

	return


func _take_damage(damage: float) -> void:
	# Apply any modifiers
	if (GM.verbose):
		print("[BATTLE ACTOR] Actor will take " + str(damage) + " damage")

	set_current_hp(get_current_HP() - damage, true)

	return


func _try_apply_status_conditions(opponentOutgoingBattleMove: OutgoingBattleMove) -> void:
	if (!opponentOutgoingBattleMove.doApplyStatusCondition):
		return

	for _statusCondition: ActiveStatusCondition in opponentOutgoingBattleMove.statusConditionsToApply:
		add_or_update_status_condition(_statusCondition)

	return


func heal(healValue: float) -> void:
	# Apply any modifiers
	if (GM.verbose):
		print("[BATTLE ACTOR] Player will heal " + str(healValue) + " hp")

	set_current_hp(get_current_HP() + healValue, true)

	return


func get_status_condition() -> Array[ActiveStatusCondition]:
	return _statusConditions


func add_or_update_status_condition(statusCondition: ActiveStatusCondition) -> void:
	var _abstractStatusCondition: AbstractBaseStatusCondition = statusCondition.get_status_condition()
	var _conditionIndex: int = -1

	for i: int in range(_statusConditions.size()):
		if (_statusConditions[i].get_status_condition() == _abstractStatusCondition):
			_statusConditions[_conditionIndex].update_status_condition(statusCondition)
			return

	_statusConditions.append(statusCondition)

	return


func force_remove_status_condition(statusCondition: ActiveStatusCondition) -> void:
	assert(_statusConditions.has(statusCondition),\
	"Being don't have the status condition " + Utils.get_clear_script_name(statusCondition))

	_statusConditions.erase(statusCondition)

	return


func get_moves() -> Array[BattleMove]:
	return _battleMoveList.duplicate(true)


func get_random_move() -> BattleMove:
	assert(_battleMoveList.size() != 0, "Can't get a random move because the move list is empty")

	return _battleMoveList[randi() % _battleMoveList.size()]


func activate_pre_turn_start_effects() -> void:
	for _statusCondition: ActiveStatusCondition in _statusConditions:
		var _abstractStatusCondition: AbstractBaseStatusCondition = _statusCondition.get_status_condition()
		var _result: StatusConditionTurnEffect = _abstractStatusCondition.pre_turn()

		if (_result != null):
			_take_damage(_result.damage)


		if (!alive()):
			return

	return


func activate_action_phase_start_effects() -> void:
	for _statusCondition: ActiveStatusCondition in _statusConditions:
		var _abstractStatusCondition: AbstractBaseStatusCondition = _statusCondition.get_status_condition()
		var _result: StatusConditionTurnEffect = _abstractStatusCondition.action_phase()

		if (_result != null):
			_take_damage(_result.damage)

		if (!alive()):
			return

	return


func activate_post_turn_start_effects() -> void:
	for _statusCondition: ActiveStatusCondition in _statusConditions:
		var _abstractStatusCondition: AbstractBaseStatusCondition = _statusCondition.get_status_condition()
		var _result: StatusConditionTurnEffect = _abstractStatusCondition.post_turn()

		if (_result != null):
			_take_damage(_result.damage)

		if (!alive()):
			return

	_update_active_status_conditions()

	return


func _update_active_status_conditions() -> void:
	for _statusCondition: ActiveStatusCondition in _statusConditions:
		_statusCondition.on_turn_finished() # ALWAYS NEED TO BE CALLED AFTER THE POST TURN EFFECT

	_statusConditions = _statusConditions.filter(func(statusCondition: ActiveStatusCondition) -> bool: return statusCondition.get_remaining_amount() > 0)

	return


func alive() -> bool:
	return get_current_HP() > 0


func get_battle_moves_by_category(category: ImportUtils.Category) -> Array[BattleMove]:
	assert(category != null, "Move category can't be null")

	var _moves: Array[BattleMove] = get_moves()
	assert(_moves.size() > 0, "No moves found")

	var _movesFromCategory: Array[BattleMove] = _moves.filter(func(move: BattleMove) -> bool: return move.category == category)

	return _movesFromCategory
