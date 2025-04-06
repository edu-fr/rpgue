class_name MoveData
extends Resource

enum Category { ATTACK, TECH }
enum MoveType { SLASH, PIERCE, STRIKE, FIRE, WATER, GRASS, LIGHT, DARK, DEFENSIVE, STATUS, STATS }
enum Target { CURRENT, ADJACENT, ALL_ENEMIES, SELF, ADJACENT_ALLIES, ALL_ALLIES }
enum ValueType { NONE, VARIABLE, ABSOLUTE }
enum ActivationWindow { NONE, PRE_HIT, STANDARD, POST_HIT }
enum StatusCondition { NONE, STAGGER, BURN, FREEZE }
enum AdditionalDamageType { NONE, FIXED, VARIABLE }
enum RequirementsToAppear { NONE, WARRIOR, MAGE, OMNIBUFF }

var privateName: String
var name: String
var description: String
var category: Category
var moveTypes: Array[MoveType]
var baseDamage: float
var baseBlock: float
var targets: Array[Target]
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

	# Campos obrigatórios
	move.privateName = data.get("PRIVATE NAME", "")
	move.name = data.get("NAME", "")
	move.description = data.get("DESCRIPTION", "")

	# Parsing de enums e listas
	move.category = _parse_category(data.get("CATEGORY", ""))
	move.moveTypes = _parse_move_types(data.get("TYPE(S)", ""))
	move.targets = _parse_targets(data.get("TARGETS", ""))
	move.statusCondition = _parse_status_condition(data.get("STATUS CONDITION", "NONE"))
	move.activationWindow = _parse_activation_window(data.get("ACTIVATION WINDOW", ""))
	move.requirements = _parse_requirement_to_appear(data.get("REQUIREMENTS TO APPEAR", ""))

	# Valores numéricos
	move.baseDamage = data.get("BASE DAMAGE", 0.0)
	move.baseBlock = data.get("BASE BLOCK", 0.0)
	move.activationChance = data.get("ACTIVATION CHANCE", 0.0)
	move.additionalDamageValue = data.get("ADDITIONAL DAMAGE VALUE", 0.0)
	move.valueToIncrease = data.get("VALUE TO INCREASE", 0.0)
	move.valueToDecrease = data.get("VALUE TO DECREASE", 0.0)

	# Outros campos
	move.additionalDamageType = _parse_additional_damage_type(data.get("ADDITIONAL DAMAGE TYPE", "NONE"))
	move.statsToIncrease = data.get("STATS TO INCREASE", "NONE")
	move.valueTypeToIncrease = _parse_value_type(data.get("VALUE TYPE TO INCREASE", ""))
	move.statsToDecrease = data.get("STATS TO DECREASE", "NONE")
	move.valueTypeToDecrease = _parse_value_type(data.get("VALUE TYPE TO DECREASE", ""))
	move.restrictions = data.get("RESTRICTIONS", "NONE")
	move.pool = data.get("POOL", 1)

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

	return types


static func _parse_targets(raw: Variant) -> Array[Target]:
	var _rawAsStr: String = str(raw)
	var _targets: Array[Target] = []

	for _targetStr: String in _rawAsStr.split(",", false):
		var _normalized: String = _targetStr.strip_edges().replace(" ", "_").to_upper()
		match _normalized:
			"CURRENT": _targets.append(Target.CURRENT)
			"ADJACENT": _targets.append(Target.ADJACENT)
			"ALL_ENEMIES": _targets.append(Target.ALL_ENEMIES)
			"SELF": _targets.append(Target.SELF)
			"ADJACENT_ALLIES": _targets.append(Target.ADJACENT_ALLIES)
			"ALL_ALLIES": _targets.append(Target.ALL_ALLIES)

	return _targets


static func _parse_status_condition(raw: Variant) -> StatusCondition:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"STAGGER": return StatusCondition.STAGGER
		"BURN": return StatusCondition.BURN
		"FREEZE": return StatusCondition.FREEZE
		_: return StatusCondition.NONE


static func _parse_activation_window(raw: Variant) -> ActivationWindow:
	var _rawAsStr: String = str(raw).replace("-", "_").strip_edges().to_upper()
	match _rawAsStr:
		"PRE_HIT": return ActivationWindow.PRE_HIT
		"STANDARD": return ActivationWindow.STANDARD
		"POST_HIT": return ActivationWindow.POST_HIT
		_: return ActivationWindow.NONE


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
		_: return ValueType.NONE


static func _parse_requirement_to_appear(raw: Variant) -> Array[RequirementsToAppear]:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	var _requirements: Array[RequirementsToAppear] = []
	for _req: String in _rawAsStr:
		match _rawAsStr:
			"NONE": _requirements.append(RequirementsToAppear.NONE)
			"WARRIOR": _requirements.append(RequirementsToAppear.WARRIOR)
			"MAGE": _requirements.append(RequirementsToAppear.MAGE)
			"OMNIBUFF": _requirements.append(RequirementsToAppear.OMNIBUFF)
			_: _requirements.append(RequirementsToAppear.NONE)

	return _requirements
