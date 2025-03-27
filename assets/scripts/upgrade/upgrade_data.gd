class_name UpgradeData

enum Category { BUFF, PENALTY }
enum AppliesTo { NONE, ATTACK, MAGIC, DEFENSE, STATS }
enum DamageType { NONE, VARIABLE, ABSOLUTE }
enum ActivationWindow { NONE, STANDARD, POST_HIT, PERMANENT }
enum ValueType { NONE, VARIABLE, ABSOLUTE }
var id: int
var name: String
var description: String
var categories: Array[Category]
var appliesTo: AppliesTo
var statsCondition: String
var activationChance: float
var damageType: DamageType
var damageValue: float
var activationWindow: ActivationWindow
var statsToIncrease: String
var valueTypeToIncrease: ValueType
var valueToIncrease: float
var statsToDecrease: String
var valueTypeToDecrease: ValueType
var valueToDecrease: float
var requirementsToAppear: String
var restrictions: String


static func create_from_json(data: Dictionary) -> UpgradeData:
	var upgrade: UpgradeData = UpgradeData.new()

	upgrade.id = data.get("ID", -1)

	upgrade.name = data.get("NAME", "")
	assert(upgrade.name != "", "Can't import upgrade without name")

	upgrade.description = data.get("DESCRIPTION", "")
	assert(upgrade.description != "", "Can't import upgrade without description")

	upgrade.categories = _parse_categories(str(data.get("CATEGORY", "")))
	upgrade.appliesTo = _parse_applies_to(str(data.get("APPLIES TO", "")))
	upgrade.statsCondition = data.get("STATS CONDITION", "")

	upgrade.activationChance = _parse_numeric(data.get("ACTIVATION CHANCE", 0.0))
	upgrade.damageValue = _parse_numeric(data.get("DAMAGE VALUE", 0.0))
	upgrade.valueToIncrease = _parse_numeric(data.get("VALUE TO INCREASE", 0.0))
	upgrade.valueToDecrease = _parse_numeric(data.get("VALUE TO DECREASE", 0.0))

	upgrade.damageType = _parse_damage_type(str(data.get("DAMAGE TYPE", "")))
	upgrade.activationWindow = _parse_activation_window(str(data.get("ACTIVATION WINDOW", "")))
	upgrade.valueTypeToIncrease = _parse_value_type(str(data.get("VALUE TYPE TO INCREASE", "")))
	upgrade.valueTypeToDecrease = _parse_value_type(str(data.get("VALUE TYPE TO DECREASE", "")))

	upgrade.statsToIncrease = data.get("STATS TO INCREASE", "")
	upgrade.statsToDecrease = data.get("STATS TO DECREASE", "")
	upgrade.requirementsToAppear = data.get("REQUIREMENTS TO APPEAR", "")
	upgrade.restrictions = data.get("RESTRICTIONS", "")

	return upgrade


static func _parse_numeric(value: Variant) -> float:
	var strValue: String = str(value)
	if strValue == "-" || strValue.is_valid_float():
		return strValue.to_float() if strValue != "-" else 0.0

	return float(strValue)


static func _parse_categories(raw: String) -> Array[Category]:
	var result: Array[Category] = []
	for item: String in raw.split(",", false):
		match item.strip_edges().to_upper():
			"BUFF":
				result.append(Category.BUFF)
			"PENALTY":
				result.append(Category.PENALTY)
	return result


static func _parse_applies_to(raw: String) -> AppliesTo:
	match raw.strip_edges().to_upper():
		"ATTACK":
			return AppliesTo.ATTACK
		"MAGIC":
			return AppliesTo.MAGIC
		"DEFENSE":
			return AppliesTo.DEFENSE
		"STATS":
			return AppliesTo.STATS
		_:
			return AppliesTo.NONE


static func _parse_damage_type(raw: String) -> DamageType:
	match raw.strip_edges().to_upper():
		"VARIABLE":
			return DamageType.VARIABLE
		"ABSOLUTE":
			return DamageType.ABSOLUTE
		_:
			return DamageType.NONE


static func _parse_activation_window(raw: String) -> ActivationWindow:
	var normalized: String = raw.replace("-", "_").strip_edges().to_upper()
	match normalized:
		"STANDARD", "STARDARD": # Corrigindo typo
			return ActivationWindow.STANDARD
		"POST_HIT":
			return ActivationWindow.POST_HIT
		"PERMANENT":
			return ActivationWindow.PERMANENT
		_:
			return ActivationWindow.NONE


static func _parse_value_type(raw: String) -> ValueType:
	match raw.strip_edges().to_upper():
		"VARIABLE":
			return ValueType.VARIABLE
		"ABSOLUTE":
			return ValueType.ABSOLUTE
		_:
			return ValueType.NONE
