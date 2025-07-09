class_name ImportUtils

enum Category { UNKNOWN, ATTACK, TECH }
enum MoveType { UNKNOWN, SLASH, PIERCE, STRIKE, FIRE, WATER, GRASS, LIGHT, DARK, DEFENSIVE, STATUS, STATS }
enum TargetType { UNKNOWN, CURRENT, ADJACENT, ALL_ENEMIES, SELF, ADJACENT_ALLIES, ALL_ALLIES }
enum ValueType { UNKNOWN, NONE, VARIABLE, ABSOLUTE }
enum ActivationWindow { UNKNOWN, NONE, PRE_HIT, STANDARD, POST_HIT }
enum AdditionalDamageType { UNKNOWN, NONE, FIXED, VARIABLE }
enum RequirementsToAppear { UNKNOWN, NONE, WARRIOR, MAGE, THIEF, OMNIBUFF, ENEMY }
enum StatType { UNKNOWN, NONE, SKILLS, MAX_HP, CURRENT_HP }
enum UpgradeType { UNKNOWN, STATS, FIRE, STATUS, DEFENSIVE, GRASS }


static func parse_category(raw: Variant) -> Category:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"ATTACK": return Category.ATTACK
		"TECH": return Category.TECH
		_:
			push_error("Categoria inválida: ", raw)
			return Category.UNKNOWN


static func parse_move_types(raw: Variant) -> Array[MoveType]:
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


static func parse_target_type(raw: Variant) -> Array[TargetType]:
	var _rawAsStr: String = str(raw)
	var parsed_targets: Array[TargetType] = []

	if _rawAsStr == "NONE" or _rawAsStr.is_empty():
		parsed_targets.append(TargetType.UNKNOWN)
		return parsed_targets

	for _targetStr: String in _rawAsStr.split(",", false):
		var normalized: String = _targetStr.strip_edges().replace(" ", "_").to_upper()
		match normalized:
			"CURRENT": parsed_targets.append(TargetType.CURRENT)
			"ADJACENT": parsed_targets.append(TargetType.ADJACENT)
			"ALL_ENEMIES": parsed_targets.append(TargetType.ALL_ENEMIES)
			"SELF": parsed_targets.append(TargetType.SELF)
			"ADJACENT_ALLIES": parsed_targets.append(TargetType.ADJACENT_ALLIES)
			"ALL_ALLIES": parsed_targets.append(TargetType.ALL_ALLIES)
			_: parsed_targets.append(TargetType.UNKNOWN)

	return parsed_targets


static func parse_status_condition(raw: Variant) -> StatusConditionEnums.Type:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"STAGGER": return StatusConditionEnums.Type.STAGGER
		"BURN": return StatusConditionEnums.Type.BURN
		"FREEZE": return StatusConditionEnums.Type.FREEZE
		"POISON": return StatusConditionEnums.Type.POISON
		"NONE": return StatusConditionEnums.Type.UNKNOWN
		_:
			push_error("Status condition desconhecida: " + _rawAsStr)
			return StatusConditionEnums.Type.UNKNOWN


static func parse_activation_window(raw: Variant) -> ActivationWindow:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"PRE-HIT": return ActivationWindow.PRE_HIT
		"STANDARD": return ActivationWindow.STANDARD
		"POST-HIT": return ActivationWindow.POST_HIT
		"NONE": return ActivationWindow.NONE
		_:
			push_error("Activation window desconhecida: " + _rawAsStr)
			return ActivationWindow.STANDARD


static func parse_additional_damage_type(raw: Variant) -> AdditionalDamageType:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"FIXED": return AdditionalDamageType.FIXED
		"VARIABLE": return AdditionalDamageType.VARIABLE
		_: return AdditionalDamageType.NONE


static func parse_value_type(raw: Variant) -> ValueType:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"VARIABLE": return ValueType.VARIABLE
		"ABSOLUTE": return ValueType.ABSOLUTE
		"NONE": return ValueType.NONE
		_: return ValueType.UNKNOWN


static func parse_requirement_to_appear(raw: Variant) -> Array[RequirementsToAppear]:
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


static func parse_stat_type(raw: Variant) -> StatType:
	var _rawAsStr: String = str(raw).replace(" ", "_").strip_edges().to_upper()
	match _rawAsStr:
		"SKILLS": return StatType.SKILLS
		"MAX_HP": return StatType.MAX_HP
		"CURRENT_HP": return StatType.CURRENT_HP
		_: return StatType.NONE


static func parse_upgrade_types(raw: Variant) -> Array[UpgradeType]:
	var _rawAsStr: String = str(raw)
	var _types: Array[UpgradeType] = []

	for _typeStr: String in _rawAsStr.split(",", false):
		var _normalized: String = _typeStr.strip_edges().to_upper()
		match _normalized:
			"STATS": _types.append(UpgradeType.STATS)
			"FIRE": _types.append(UpgradeType.FIRE)
			"STATUS": _types.append(UpgradeType.STATUS)
			"DEFENSIVE": _types.append(UpgradeType.DEFENSIVE)
			"GRASS": _types.append(UpgradeType.GRASS)

	return _types


static func parse_immunities(raw: Variant) -> Array[StatusConditionEnums.Type]:
	var _rawAsStr: String = str(raw)
	var immunities: Array[StatusConditionEnums.Type] = []

	if _rawAsStr == "NONE" or _rawAsStr.is_empty():
		immunities.append(StatusConditionEnums.Type.UNKNOWN)
		return immunities

	for _immunity: String in _rawAsStr.split(",", false):
		var normalized: String = _immunity.strip_edges().to_upper()
		match normalized:
			"STAGGER": immunities.append(StatusConditionEnums.Type.STAGGER)
			"BURN": immunities.append(StatusConditionEnums.Type.BURN)
			"FREEZE": immunities.append(StatusConditionEnums.Type.FREEZE)
			"POISON": immunities.append(StatusConditionEnums.Type.POISON)
			"NONE": immunities.append(StatusConditionEnums.Type.UNKNOWN)
			_:
				push_error("Status condition desconhecida: " + normalized)
				immunities.append(StatusConditionEnums.Type.UNKNOWN)

	return immunities