class_name UpgradeData

enum Category { ATTACK, TECH, UPGRADE }
enum MoveType { SLASH, FIRE, WATER, DEFENSIVE, STATUS, STATS, GRASS }
enum Target { CURRENT, ADJACENT, ALL_ENEMIES, SELF, ADJACENT_ALLIES }
enum ValueType { NONE, VARIABLE, ABSOLUTE }
enum ActivationWindow { NONE, STANDARD, POST_HIT }
enum Requirement { WARRIOR, MAGE, OMNIBUFF }
var privateName: String
var name: String
var description: String
var category: Category
var moveTypes: Array[MoveType]
var baseDamage: float
var baseBlock: float
var targets: Array[Target]
var statsCondition: String
var activationChance: float
var activationWindow: ActivationWindow
var statsToIncrease: String
var valueTypeToIncrease: ValueType
var valueToIncrease: float
var statsToDecrease: String
var valueTypeToDecrease: ValueType
var valueToDecrease: float
var requirements: Array[Requirement]
var restrictions: String
var pool: int


static func create_from_json(data: Dictionary) -> UpgradeData:
	var upgrade := UpgradeData.new()

	# Validação de campos obrigatórios
	upgrade.privateName = data.get("PRIVATE NAME", "")
	assert(upgrade.privateName != "", "Missing PRIVATE NAME in upgrade data")

	upgrade.name = data.get("NAME", "")
	assert(upgrade.name != "", "Missing NAME in upgrade data")

	upgrade.description = data.get("DESCRIPTION", "")
	assert(upgrade.description != "", "Missing DESCRIPTION in upgrade data")

	upgrade.category = _parse_category(data.get("CATEGORY", ""))
	upgrade.moveTypes = _parse_move_types(data.get("TYPE(S)", ""))
	upgrade.targets = _parse_targets(data.get("TARGETS", ""))
	upgrade.requirements = _parse_requirements(data.get("REQUIREMENTS TO APPEAR", ""))

	upgrade.baseDamage = _parse_numeric(data.get("BASE DAMAGE", 0.0))
	upgrade.baseBlock = _parse_numeric(data.get("BASE BLOCK", 0.0))
	upgrade.activationChance = _parse_numeric(data.get("ACTIVATION CHANCE", 0.0))
	upgrade.valueToIncrease = _parse_numeric(data.get("VALUE TO INCREASE", 0.0))
	upgrade.valueToDecrease = _parse_numeric(data.get("VALUE TO DECREASE", 0.0))

	upgrade.statsCondition = data.get("STATS CONDITION", "")
	upgrade.activationWindow = _parse_activation_window(data.get("ACTIVATION WINDOW", ""))
	upgrade.valueTypeToIncrease = _parse_value_type(data.get("VALUE TYPE TO INCREASE", ""))
	upgrade.valueTypeToDecrease = _parse_value_type(data.get("VALUE TYPE TO DECREASE", ""))
	upgrade.statsToIncrease = data.get("STATS TO INCREASE", "")
	upgrade.statsToDecrease = data.get("STATS TO DECREASE", "")
	upgrade.restrictions = data.get("RESTRICTIONS", "")
	upgrade.pool = data.get("POOL", 1)

	return upgrade


#region Parsing Methods
static func _parse_category(raw: String) -> Category:
	match raw.strip_edges().to_upper():
		"ATTACK": return Category.ATTACK
		"TECH": return Category.TECH
		"UPGRADE": return Category.UPGRADE
		_:
			push_error("Categoria inválida: ", raw)

			return Category.ATTACK


static func _parse_move_types(raw: String) -> Array[MoveType]:
	var types: Array[MoveType] = []
	for type: String in raw.split(",", false):
		match type.strip_edges().to_upper():
			"SLASH": types.append(MoveType.SLASH)
			"FIRE": types.append(MoveType.FIRE)
			"WATER": types.append(MoveType.WATER)
			"DEFENSIVE": types.append(MoveType.DEFENSIVE)
			"STATUS": types.append(MoveType.STATUS)
			"STATS": types.append(MoveType.STATS)
			"GRASS": types.append(MoveType.GRASS)

	return types


static func _parse_targets(raw: String) -> Array[Target]:
	var targets: Array[Target] = []
	for target: String in raw.split(",", false):
		match target.strip_edges().replace(" ", "_").to_upper():
			"CURRENT": targets.append(Target.CURRENT)
			"ADJACENT": targets.append(Target.ADJACENT)
			"ALL_ENEMIES": targets.append(Target.ALL_ENEMIES)
			"SELF": targets.append(Target.SELF)
			"ADJACENT_ALLIES": targets.append(Target.ADJACENT_ALLIES)

	return targets


static func _parse_requirements(raw: String) -> Array[Requirement]:
	var reqs: Array[Requirement] = []
	for req: String in raw.split(",", false):
		match req.strip_edges().to_upper():
			"WARRIOR": reqs.append(Requirement.WARRIOR)
			"MAGE": reqs.append(Requirement.MAGE)
			"OMNIBUFF": reqs.append(Requirement.OMNIBUFF)

	return reqs


static func _parse_activation_window(raw: String) -> ActivationWindow:
	var normalized: String = raw.replace("-", "_").strip_edges().to_upper()
	match normalized:
		"STANDARD": return ActivationWindow.STANDARD
		"POST_HIT": return ActivationWindow.POST_HIT

		_: return ActivationWindow.NONE


static func _parse_value_type(raw: String) -> ValueType:
	match raw.strip_edges().to_upper():
		"VARIABLE": return ValueType.VARIABLE
		"ABSOLUTE": return ValueType.ABSOLUTE

		_: return ValueType.NONE


static func _parse_numeric(value: Variant) -> float:
	if typeof(value) == TYPE_STRING:
		if value == "-": return 0.0
		if value.is_valid_float(): return value.to_float()

	return float(value)
