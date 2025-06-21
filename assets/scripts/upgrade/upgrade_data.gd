class_name UpgradeData
extends Resource

enum UpgradeType { UNKNOWN, STATS, FIRE, STATUS, DEFENSIVE, GRASS }
enum UpgradeTarget { UNKNOWN, SELF, ALLY, ENEMY }
enum ValueType { UNKNOWN, NONE, VARIABLE, ABSOLUTE }
enum StatType { UNKNOWN, NONE, SKILLS, MAX_HP, CURRENT_HP }
enum RequirementsToAppear { UNKNOWN, NONE, WARRIOR, MAGE, OMNIBUFF, ENEMY, THIEF }

var privateName: String
var name: String
var description: String
var upgradeTypes: Array[UpgradeType]
var targets: Array[UpgradeTarget]
var activationChance: float
var additionalDamageType: String
var additionalDamageValue: float
var statsToIncrease: StatType
var valueTypeToIncrease: ValueType
var valueToIncrease: float
var statsToDecrease: StatType
var valueTypeToDecrease: ValueType
var valueToDecrease: float
var requirements: Array[RequirementsToAppear]
var restrictions: String
var pool: int


static func create_from_json(data: Dictionary) -> UpgradeData:
	var upgrade: UpgradeData = UpgradeData.new()

	upgrade.privateName = Utils.get_data(data, "PRIVATE NAME", "")
	upgrade.name = Utils.get_data(data, "NAME", "")
	upgrade.description = Utils.get_data(data, "DESCRIPTION", "")

	upgrade.upgradeTypes = _parse_upgrade_types(Utils.get_data(data, "TYPE(S)", ""))
	upgrade.targets = _parse_targets(Utils.get_data(data, "TARGETS", ""))
	upgrade.statsToIncrease = _parse_stat_type(Utils.get_data(data, "STATS TO INCREASE", "NONE"))
	upgrade.valueTypeToIncrease = _parse_value_type(Utils.get_data(data, "VALUE TYPE TO INCREASE", ""))
	upgrade.statsToDecrease = _parse_stat_type(Utils.get_data(data, "STATS TO DECREASE", "NONE"))
	upgrade.valueTypeToDecrease = _parse_value_type(Utils.get_data(data, "VALUE TYPE TO DECREASE", ""))

	upgrade.activationChance = Utils.get_data(data, "ACTIVATION CHANCE", 0.0)
	upgrade.additionalDamageValue = Utils.get_data(data, "ADDITIONAL DAMAGE VALUE", 0.0)
	upgrade.valueToIncrease = Utils.get_data(data, "VALUE TO INCREASE", 0.0)
	upgrade.valueToDecrease = Utils.get_data(data, "VALUE TO DECREASE", 0.0)
	upgrade.requirements = _parse_requirement_to_appear(Utils.get_data(data, "REQUIREMENTS TO APPEAR", ""))
	upgrade.restrictions = Utils.get_data(data, "RESTRICTIONS", "NONE")
	upgrade.pool = Utils.get_data(data, "POOL", 1)

	return upgrade


# UpgradeData.gd
static func _parse_upgrade_types(raw: Variant) -> Array[UpgradeType]:
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


static func _parse_stat_type(raw: Variant) -> StatType:
	var _rawAsStr: String = str(raw).replace(" ", "_").strip_edges().to_upper()
	match _rawAsStr:
		"SKILLS": return StatType.SKILLS
		"MAX_HP": return StatType.MAX_HP
		"CURRENT_HP": return StatType.CURRENT_HP
		_: return StatType.NONE


static func _parse_targets(raw: Variant) -> Array[UpgradeTarget]:
	var _rawAsStr: String = str(raw)
	var _targets: Array[UpgradeTarget] = []

	for _targetStr: String in _rawAsStr.split(",", false):
		var _normalized: String = _targetStr.strip_edges().replace(" ", "_").to_upper()
		match _normalized:
			"SELF": _targets.append(UpgradeTarget.SELF)
			"ALLY": _targets.append(UpgradeTarget.ALLY)
			"ENEMY": _targets.append(UpgradeTarget.ENEMY)

	return _targets


static func _parse_value_type(raw: Variant) -> ValueType:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	match _rawAsStr:
		"VARIABLE": return ValueType.VARIABLE
		"ABSOLUTE": return ValueType.ABSOLUTE
		_: return ValueType.NONE


static func _parse_requirement_to_appear(raw: Variant) -> Array[RequirementsToAppear]:
	var _rawAsStr: String = str(raw).strip_edges().to_upper()
	var _requirements: Array[RequirementsToAppear] = []

	# Se for NONE ou vazio, retorna array com NONE
	if _rawAsStr == "NONE" or _rawAsStr.is_empty():
		_requirements.append(RequirementsToAppear.NONE)
		return _requirements

	# Divide a string em partes separadas por vírgula
	for _req: String in _rawAsStr.split(",", false):
		var requirement: String = _req.strip_edges()
		match requirement:
			"WARRIOR": _requirements.append(RequirementsToAppear.WARRIOR)
			"MAGE": _requirements.append(RequirementsToAppear.MAGE)
			"THIEF": _requirements.append(RequirementsToAppear.THIEF)
			"OMNIBUFF": _requirements.append(RequirementsToAppear.OMNIBUFF)
			_: _requirements.append(RequirementsToAppear.NONE)

	return _requirements


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
