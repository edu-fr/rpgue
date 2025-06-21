class_name BattleMove

var publicName: String
var description: String
var moveTypes: Array[MoveData.MoveType]
var category: MoveData.Category
var power: float

var _baseMoveData: MoveData


func _init(moveData: MoveData, user: BattleActor) -> void:
	_baseMoveData = moveData
	publicName = moveData.name
	description = moveData.description
	moveTypes = moveData.moveTypes
	category = moveData.category
	power = _baseMoveData.baseDamage * user.get_attack_damage_multiplier()

	return


func get_move_data() -> MoveData:
	return _baseMoveData