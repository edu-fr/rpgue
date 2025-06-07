class_name BattleMove

var publicName: String
var description: String
var moveTypes: Array[MoveData.MoveType]
var category: MoveData.Category

var _moveData: MoveData


func _init(moveData: MoveData) -> void:
	_moveData = moveData

	publicName = moveData.name
	description = moveData.description
	moveTypes = moveData.moveTypes
	category = moveData.category

	return


func get_move_data() -> MoveData:
	return _moveData