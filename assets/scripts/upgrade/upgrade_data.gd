class_name UpgradeData
extends Resource

var privateName: String
var name: String
var description: String
var upgradeTypes: Array[ImportUtils.UpgradeType]
var targets: Array[ImportUtils.TargetType]
var activationChance: float
var additionalDamageType: String
var additionalDamageValue: float
var statsToIncrease: ImportUtils.StatType
var valueTypeToIncrease: ImportUtils.ValueType
var valueToIncrease: float
var statsToDecrease: ImportUtils.StatType
var valueTypeToDecrease: ImportUtils.ValueType
var valueToDecrease: float
var requirements: Array[ImportUtils.RequirementsToAppear]
var restrictions: String
var pool: int


static func create_from_json(data: Dictionary) -> UpgradeData:
	var upgrade: UpgradeData = UpgradeData.new()

	upgrade.privateName = Utils.get_data(data, "PRIVATE NAME", "")
	upgrade.name = Utils.get_data(data, "NAME", "")
	upgrade.description = Utils.get_data(data, "DESCRIPTION", "")

	upgrade.upgradeTypes = ImportUtils.parse_upgrade_types(Utils.get_data(data, "TYPE(S)", ""))
	upgrade.targets = ImportUtils.parse_target_type(Utils.get_data(data, "TARGETS", ""))
	upgrade.statsToIncrease = ImportUtils.parse_stat_type(Utils.get_data(data, "STATS TO INCREASE", "NONE"))
	upgrade.valueTypeToIncrease = ImportUtils.parse_value_type(Utils.get_data(data, "VALUE TYPE TO INCREASE", ""))
	upgrade.statsToDecrease = ImportUtils.parse_stat_type(Utils.get_data(data, "STATS TO DECREASE", "NONE"))
	upgrade.valueTypeToDecrease = ImportUtils.parse_value_type(Utils.get_data(data, "VALUE TYPE TO DECREASE", ""))

	upgrade.activationChance = Utils.get_data(data, "ACTIVATION CHANCE", 0.0)
	upgrade.additionalDamageValue = Utils.get_data(data, "ADDITIONAL DAMAGE VALUE", 0.0)
	upgrade.valueToIncrease = Utils.get_data(data, "VALUE TO INCREASE", 0.0)
	upgrade.valueToDecrease = Utils.get_data(data, "VALUE TO DECREASE", 0.0)
	upgrade.requirements = ImportUtils.parse_requirement_to_appear(Utils.get_data(data, "REQUIREMENTS TO APPEAR", ""))
	upgrade.restrictions = Utils.get_data(data, "RESTRICTIONS", "NONE")
	upgrade.pool = Utils.get_data(data, "POOL", 1)

	return upgrade


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
