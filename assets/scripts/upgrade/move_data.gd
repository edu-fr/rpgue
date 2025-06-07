class_name MoveData
extends Resource

enum Category { UNKNOWN, ATTACK, TECH }
enum MoveType { UNKNOWN, SLASH, PIERCE, STRIKE, FIRE, WATER, GRASS, LIGHT, DARK, DEFENSIVE, STATUS, STATS }
enum MoveTarget { UNKNOWN, CURRENT, ADJACENT, ALL_ENEMIES, SELF, ADJACENT_ALLIES, ALL_ALLIES }
enum ValueType { UNKNOWN, NONE, VARIABLE, ABSOLUTE }
enum ActivationWindow { UNKNOWN, NONE, PRE_HIT, STANDARD, POST_HIT }
enum StatusCondition { UNKNOWN, NONE, STAGGER, BURN, FREEZE }
enum AdditionalDamageType { UNKNOWN, NONE, FIXED, VARIABLE }
enum RequirementsToAppear { UNKNOWN, NONE, WARRIOR, MAGE, THIEF, OMNIBUFF, ENEMY }
var privateName: String
var name: String
var description: String
var category: Category
var moveTypes: Array[MoveType]
var baseDamage: float
var baseBlock: float
var targets: Array[MoveTarget]
var statusCondition: StatusCondition
var activationChance: float
var additionalDamageType: AdditionalDamageType
var additionalDamageValue: float
var activationWindow: ActivationWindow
var statsToIncrease: String
var valueTypeToIncrease: ValueType
var valueToIncrease: float
var statsToDecrease: String
var valueTypeToDecrease: ValueType
var valueToDecrease: float
var requirements: Array[RequirementsToAppear]
var restrictions: String
var pool: int


static func create_from_json(data: Dictionary) -> MoveData:
	var move: MoveData = MoveData.new()

	move.privateName = str(data.get("PRIVATE NAME", ""))
	move.name = str(data.get("NAME", ""))
	move.description = str(data.get("DESCRIPTION", ""))

	move.category = _parse_category(data.get("CATEGORY", ""))
	move.moveTypes = _parse_move_types(data.get("TYPE(S)", ""))
	var parsed_targets: Array[MoveTarget] = _parse_targets(data.get("TARGETS", ""))
	move.targets = parsed_targets
	move.statusCondition = _parse_status_condition(data.get("STATUS CONDITION", "NONE"))
	move.activationWindow = _parse_activation_window(data.get("ACTIVATION WINDOW", "STANDARD"))
	move.additionalDamageType = _parse_additional_damage_type(data.get("ADDITIONAL DAMAGE TYPE", "NONE"))
	move.valueTypeToIncrease = _parse_value_type(data.get("VALUE TYPE TO INCREASE", "NONE"))
	move.valueTypeToDecrease = _parse_value_type(data.get("VALUE TYPE TO DECREASE", "NONE"))
	move.requirements = _parse_requirement_to_appear(data.get("REQUIREMENTS TO APPEAR", "NONE"))

	move.baseDamage = float(str(data.get("BASE DAMAGE", 0.0)))
	move.baseBlock = float(str(data.get("BASE BLOCK", 0.0)))
	move.activationChance = float(str(data.get("ACTIVATION CHANCE", 0.0)))
	move.additionalDamageValue = float(str(data.get("ADDITIONAL DAMAGE VALUE", 0.0)))
	move.valueToIncrease = float(str(data.get("VALUE TO INCREASE", 0.0)))
	move.valueToDecrease = float(str(data.get("VALUE TO DECREASE", 0.0)))
	move.pool = int(str(data.get("POOL", 1)))

	move.statsToIncrease = str(data.get("STATS TO INCREASE", "NONE"))
	move.statsToDecrease = str(data.get("STATS TO DECREASE", "NONE"))
	move.restrictions = str(data.get("RESTRICTIONS", "NONE"))

	return move


static func _parse_category(raw: Variant) -> Category:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"ATTACK": return Category.ATTACK
		"TECH": return Category.TECH
		_:
			push_error("Categoria inválida: ", raw)
			return Category.ATTACK


static func _parse_move_types(raw: Variant) -> Array[MoveType]:
	var _rawAsStr: String = str(raw)
	var types: Array[MoveType] = []

	for _typeStr: String in _rawAsStr.split(",", false):
		var normalized: String = _typeStr.strip_edges().to_upper()
		match normalized:
			"SLASH": types.append(MoveType.SLASH)
			"PIERCE": types.append(MoveType.PIERCE)
			"STRIKE": types.append(MoveType.STRIKE)
			"FIRE": types.append(MoveType.FIRE)
			"WATER": types.append(MoveType.WATER)
			"GRASS": types.append(MoveType.GRASS)
			"LIGHT": types.append(MoveType.LIGHT)
			"DARK": types.append(MoveType.DARK)
			"DEFENSIVE": types.append(MoveType.DEFENSIVE)
			"STATUS": types.append(MoveType.STATUS)
			"STATS": types.append(MoveType.STATS)
			_: types.append(MoveType.UNKNOWN)

	return types


static func _parse_targets(raw: Variant) -> Array[MoveTarget]:
	var _rawAsStr: String = str(raw)
	var parsed_targets: Array[MoveTarget] = []

	if _rawAsStr == "NONE" or _rawAsStr.is_empty():
		parsed_targets.append(MoveTarget.UNKNOWN)
		return parsed_targets

	for _targetStr: String in _rawAsStr.split(",", false):
		var normalized: String = _targetStr.strip_edges().replace(" ", "_").to_upper()
		match normalized:
			"CURRENT": parsed_targets.append(MoveTarget.CURRENT)
			"ADJACENT": parsed_targets.append(MoveTarget.ADJACENT)
			"ALL_ENEMIES": parsed_targets.append(MoveTarget.ALL_ENEMIES)
			"SELF": parsed_targets.append(MoveTarget.SELF)
			"ADJACENT_ALLIES": parsed_targets.append(MoveTarget.ADJACENT_ALLIES)
			"ALL_ALLIES": parsed_targets.append(MoveTarget.ALL_ALLIES)
			_: parsed_targets.append(MoveTarget.UNKNOWN)

	return parsed_targets


static func _parse_status_condition(raw: Variant) -> StatusCondition:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"STAGGER": return StatusCondition.STAGGER
		"BURN": return StatusCondition.BURN
		"FREEZE": return StatusCondition.FREEZE
		"NONE": return StatusCondition.NONE
		_:
			push_error("Status condition desconhecida: " + _rawAsStr)
			return StatusCondition.NONE


static func _parse_activation_window(raw: Variant) -> ActivationWindow:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"PRE_HIT": return ActivationWindow.PRE_HIT
		"STANDARD": return ActivationWindow.STANDARD
		"POST_HIT": return ActivationWindow.POST_HIT
		"NONE": return ActivationWindow.NONE
		_:
			push_error("Activation window desconhecida: " + _rawAsStr)
			return ActivationWindow.STANDARD


static func _parse_additional_damage_type(raw: Variant) -> AdditionalDamageType:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"FIXED": return AdditionalDamageType.FIXED
		"VARIABLE": return AdditionalDamageType.VARIABLE
		_: return AdditionalDamageType.NONE


static func _parse_value_type(raw: Variant) -> ValueType:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"VARIABLE": return ValueType.VARIABLE
		"ABSOLUTE": return ValueType.ABSOLUTE
		"NONE": return ValueType.NONE
		_: return ValueType.UNKNOWN


static func _parse_requirement_to_appear(raw: Variant) -> Array[RequirementsToAppear]:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	var _requirements: Array[RequirementsToAppear] = []

	if _rawAsStr == "NONE" or _rawAsStr.is_empty():
		_requirements.append(RequirementsToAppear.NONE)
		return _requirements

	for _req: String in _rawAsStr.split(",", false):
		var requirement: String = _req.strip_edges()
		match requirement:
			"WARRIOR": _requirements.append(RequirementsToAppear.WARRIOR)
			"MAGE": _requirements.append(RequirementsToAppear.MAGE)
			"THIEF": _requirements.append(RequirementsToAppear.THIEF)
			"OMNIBUFF": _requirements.append(RequirementsToAppear.OMNIBUFF)
			"ENEMY": _requirements.append(RequirementsToAppear.ENEMY)
			"NONE": _requirements.append(RequirementsToAppear.NONE)
			_:
				push_error("Requirement desconhecido: " + requirement)
				_requirements.append(RequirementsToAppear.NONE)

	return _requirements


func _to_string() -> String:
	return ObjectPrinter.print_object(self)