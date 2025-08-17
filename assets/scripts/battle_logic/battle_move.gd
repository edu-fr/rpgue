class_name BattleMove

var publicName: String
var description: String
var moveTypes: Array[ImportUtils.MoveType]
var category: ImportUtils.Category
var power: float
var _owner: BattleActor
var _baseMoveData: MoveData


func _init(moveData: MoveData, user: BattleActor) -> void:
	_baseMoveData = moveData
	_owner = user

	publicName = moveData.name
	description = moveData.description
	moveTypes = moveData.moveTypes
	category = moveData.category
	power = _baseMoveData.baseDamage

	return


func get_move_data() -> MoveData:
	return _baseMoveData


func get_use_result(target: BattleActor) -> OutgoingBattleMove:
	var _damageToDeal: float = power * _owner.get_attack_damage_multiplier()

	var _statusConditionsAsEnumList: Array[StatusConditionEnums.Type] = []
	_statusConditionsAsEnumList.append(get_move_data().statusCondition)
	var _willApplyStatus: bool = GM.rng.randfn() <= get_move_data().activationChance

	var _statusConditionsToApply: Array[ActiveStatusCondition] = []
	for _statusConditionEnum: StatusConditionEnums.Type in _statusConditionsAsEnumList:
		var _statusConditionImplementation: AbstractBaseStatusCondition = StatusConditionFactory.create_status_condition(_statusConditionEnum)
		_statusConditionsToApply.append(ActiveStatusCondition.new(_owner, target, _statusConditionImplementation, 3))

	return OutgoingBattleMove.new(_damageToDeal, moveTypes, _statusConditionsToApply, _willApplyStatus)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
