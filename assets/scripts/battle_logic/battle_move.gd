class_name BattleMove

enum MOVE_TYPE { ATTACK, TECH }
var _moveType: MOVE_TYPE


func _init(moveType: MOVE_TYPE) -> void:
	_moveType = moveType

	return
