class_name UpgradeData
extends Resource

enum UpgradeType { STATS, FIRE, STATUS, DEFENSIVE, GRASS }
enum Target { SELF, ALLY, ENEMY }
enum ValueType { NONE, VARIABLE, ABSOLUTE }
enum StatType { NONE, SKILLS, MAX_HP, CURRENT_HP }
enum RequirementsToAppear { NONE, WARRIOR, MAGE, OMNIBUFF }

var privateName: String
var name: String
var description: String
var upgradeTypes: Array[UpgradeType]
var targets: Array[Target]
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
	var upgrade = UpgradeData.new()

	upgrade.privateName = data.get("PRIVATE NAME", "")
	upgrade.name = data.get("NAME", "")
	upgrade.description = data.get("DESCRIPTION", "")

	upgrade.upgradeTypes = _parse_upgrade_types(data.get("TYPE(S)", ""))
	upgrade.targets = _parse_targets(data.get("TARGETS", ""))
	upgrade.statsToIncrease = _parse_stat_type(data.get("STATS TO INCREASE", "NONE"))
	upgrade.valueTypeToIncrease = _parse_value_type(data.get("VALUE TYPE TO INCREASE", ""))
	upgrade.statsToDecrease = _parse_stat_type(data.get("STATS TO DECREASE", "NONE"))
	upgrade.valueTypeToDecrease = _parse_value_type(data.get("VALUE TYPE TO DECREASE", ""))

	upgrade.activationChance = data.get("ACTIVATION CHANCE", 0.0)
	upgrade.additionalDamageValue = data.get("ADDITIONAL DAMAGE VALUE", 0.0)
	upgrade.valueToIncrease = data.get("VALUE TO INCREASE", 0.0)
	upgrade.valueToDecrease = data.get("VALUE TO DECREASE", 0.0)
	upgrade.requirements = _parse_requirement_to_appear(data.get("REQUIREMENTS TO APPEAR", ""))
	upgrade.restrictions = data.get("RESTRICTIONS", "NONE")
	upgrade.pool = data.get("POOL", 1)

	return upgrade


# UpgradeData.gd
static func _parse_upgrade_types(raw: Variant) -> Array[UpgradeType]:
	var rawAsStr: String = str(raw)
	var types: Array[UpgradeType] = []

	for typeStr in rawAsStr.split(",", false):
		var normalized = typeStr.strip_edges().to_upper()
		match normalized:
			"STATS": types.append(UpgradeType.STATS)
			"FIRE": types.append(UpgradeType.FIRE)
			"STATUS": types.append(UpgradeType.STATUS)
			"DEFENSIVE": types.append(UpgradeType.DEFENSIVE)
			"GRASS": types.append(UpgradeType.GRASS)

	return types


static func _parse_stat_type(raw: Variant) -> StatType:
	var rawAsStr: String = str(raw).replace(" ", "_").strip_edges().to_upper()
	match rawAsStr:
		"SKILLS": return StatType.SKILLS
		"MAX_HP": return StatType.MAX_HP
		"CURRENT_HP": return StatType.CURRENT_HP
		_: return StatType.NONE


static func _parse_targets(raw: Variant) -> Array[Target]:
	var rawAsStr: String = str(raw)
	var targets: Array[Target] = []

	for targetStr in rawAsStr.split(",", false):
		var normalized = targetStr.strip_edges().replace(" ", "_").to_upper()
		match normalized:
			"SELF": targets.append(Target.SELF)
			"ALLY": targets.append(Target.ALLY)
			"ENEMY": targets.append(Target.ENEMY)

	return targets


static func _parse_value_type(raw: Variant) -> ValueType:
	var rawAsStr: String = str(raw).strip_edges().to_upper()
	match rawAsStr:
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
