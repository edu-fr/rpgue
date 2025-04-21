class_name BattleMove

var publicName: String
var description: String
var moveTypes: Array[MoveData.MoveType]

var _playerInstance: PlayerInstance
var _moveData: MoveData


func _init(moveData: MoveData, player: PlayerInstance) -> void:
	_moveData = moveData
	_playerInstance = player

	publicName = moveData.name
	description = moveData.description
	moveTypes = moveData.moveTypes

	return


func getMoveData() -> MoveData:
	return _moveData