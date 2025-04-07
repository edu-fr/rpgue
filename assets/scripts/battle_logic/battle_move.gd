class_name BattleMove

var _publicName: String
var _description: String
var _moveTypes: Array[MoveData.MoveType]


func _init(moveData: MoveData, player: PlayerInstance) -> void:
	_publicName = moveData.name
	_description = moveData.description
	_moveTypes = moveData.moveTypes

	return
