class_name EnemyInstance
extends LivingBeing

var _enemyData: EnemyData

func _init(privateName: String) -> void:
	## MOCK
	_enemyData = GM.dataManager.get_enemy_data_with_name(privateName)

	var _enemyBattleAttackMoves: Array[BattleMove]
	var _enemyBattleTechMoves: Array[BattleMove];

	for _moveName: String in _enemyData.moveNameList:
		var _move: MoveData = GM.dataManager._externalGameConfig.get_move_data_with_name(_moveName)
		if (_move.category == MoveData.Category.ATTACK):
			_enemyBattleAttackMoves.append(BattleMove.new(_move, self))
		elif (_move.category == MoveData.Category.TECH):
			_enemyBattleTechMoves.append(BattleMove.new(_move, self))

	var _totalMoves: Array[BattleMove]
	_totalMoves.append_array(_enemyBattleAttackMoves.duplicate(true))
	_totalMoves.append_array(_enemyBattleTechMoves.duplicate(true))

	assert(_totalMoves.size() > 0, "Couldn't create enemy total battle moves array")

	super(_enemyData.maxHP, _enemyData.startingHP, _enemyData.baseDamage, _totalMoves)

	print("enemy instance criada! Total moves list count: " + str(_totalMoves.size()) + "; Move list count: " + str(_moveList.size()))

	return

