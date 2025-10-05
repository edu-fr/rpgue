class_name SelectedBattleMove

var battleMove: BattleMove
var targetEnemiesIds: Array[int]

func _init(battleMove: BattleMove, targetEnemiesIds: Array[int]) -> void:
	self.battleMove = battleMove
	self.targetEnemiesIds = targetEnemiesIds

	return
