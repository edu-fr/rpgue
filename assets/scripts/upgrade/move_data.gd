class_name MoveData
extends Resource

var privateName: String
var name: String
var description: String
var category: ImportUtils.Category
var moveTypes: Array[ImportUtils.MoveType]
var baseDamage: float
var baseBlock: float
var targets: Array[ImportUtils.TargetType]
var statusCondition: StatusConditionEnums.Type
var activationChance: float
var additionalDamageType: ImportUtils.AdditionalDamageType
var additionalDamageValue: float
var activationWindow: ImportUtils.ActivationWindow
var statsToIncrease: String
var valueTypeToIncrease: ImportUtils.ValueType
var valueToIncrease: float
var statsToDecrease: String
var valueTypeToDecrease: ImportUtils.ValueType
var valueToDecrease: float
var requirements: Array[ImportUtils.RequirementsToAppear]
var restrictions: String
var pool: int


static func create_from_json(data: Dictionary) -> MoveData:
	var move: MoveData = MoveData.new()

	move.privateName = str(Utils.get_data(data, "PRIVATE NAME", "")).replace(" ", "")
	move.name = str(Utils.get_data(data, "NAME", ""))
	move.description = str(Utils.get_data(data, "DESCRIPTION", ""))
	move.category = ImportUtils.parse_category(Utils.get_data(data, "CATEGORY", ""))
	move.moveTypes = ImportUtils.parse_move_types(Utils.get_data(data, "TYPE(S)", ""))
	var parsed_targets: Array[ImportUtils.TargetType] = ImportUtils.parse_target_type(Utils.get_data(data, "TARGETS", ""))
	move.targets = parsed_targets
	move.statusCondition = ImportUtils.parse_status_condition(Utils.get_data(data, "STATUS CONDITION", "NONE"))
	move.activationWindow = ImportUtils.parse_activation_window(Utils.get_data(data, "ACTIVATION WINDOW", "STANDARD"))
	move.additionalDamageType = ImportUtils.parse_additional_damage_type(Utils.get_data(data, "ADDITIONAL DAMAGE TYPE", "NONE"))
	move.valueTypeToIncrease = ImportUtils.parse_value_type(Utils.get_data(data, "VALUE TYPE TO INCREASE", "NONE"))
	move.valueTypeToDecrease = ImportUtils.parse_value_type(Utils.get_data(data, "VALUE TYPE TO DECREASE", "NONE"))
	move.requirements = ImportUtils.parse_requirement_to_appear(Utils.get_data(data, "REQUIREMENTS TO APPEAR", "NONE"))

	move.baseDamage = float(str(Utils.get_data(data, "BASE DAMAGE", 0.0)))
	move.baseBlock = float(str(Utils.get_data(data, "BASE BLOCK", 0.0)))
	move.activationChance = float(str(Utils.get_data(data, "ACTIVATION CHANCE", 0.0)))
	move.additionalDamageValue = float(str(Utils.get_data(data, "ADDITIONAL DAMAGE VALUE", 0.0)))
	move.valueToIncrease = float(str(Utils.get_data(data, "VALUE TO INCREASE", 0.0)))
	move.valueToDecrease = float(str(Utils.get_data(data, "VALUE TO DECREASE", 0.0)))
	move.pool = int(str(Utils.get_data(data, "POOL", 1)))

	move.statsToIncrease = str(Utils.get_data(data, "STATS TO INCREASE", "NONE"))
	move.statsToDecrease = str(Utils.get_data(data, "STATS TO DECREASE", "NONE"))
	move.restrictions = str(Utils.get_data(data, "RESTRICTIONS", "NONE"))

	return move


func _to_string() -> String:
	return ObjectPrinter.print_object(self)