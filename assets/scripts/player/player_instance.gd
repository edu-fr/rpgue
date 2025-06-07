class_name PlayerInstance
extends LivingBeing

var _playerClassData: PlayerClassData

func _init() -> void:
	## MOCK
	_playerClassData = GM.dataManager.get_player_default_class_data().get_player_default_class_data().duplicate(true)

	var _playerBattleAttackMoves: Array[BattleMove]
	var _playerBattleTechMoves: Array[BattleMove];

	for _moveName: String in _playerClassData.initialMoveNameList:
		var _move: MoveData = GM.dataManager._externalGameConfig.get_move_with_name(_moveName)
		if (_move.category == MoveData.Category.ATTACK):
			_playerBattleAttackMoves.append(BattleMove.new(_move))
		elif (_move.category == MoveData.Category.TECH):
			_playerBattleTechMoves.append(BattleMove.new(_move))

	var _totalMoves: Array[BattleMove]
	_totalMoves.append_array(_playerBattleAttackMoves.duplicate(true))
	_totalMoves.append_array(_playerBattleTechMoves.duplicate(true))

	assert(_totalMoves.size() > 0, "Couldn't create player total battle moves array")

	super(_playerClassData.baseMaxHP, _playerClassData.baseMaxHP, _playerClassData.baseDamage, _totalMoves)

	print("Player instance criada! Total moves list count: " + str(_totalMoves.size()) + "; Move list count: " + str(_moveList.size()))

	return


func get_battle_moves_by_category(category: MoveData.Category) -> Array[BattleMove]:
	assert(category != null, "Move category can't be null")

	var _moves: Array[BattleMove] = get_moves()
	assert(_moves.size() > 0, "No moves found on player")

	var _movesFromCategory: Array[BattleMove] = \
	_moves.filter(func(move: BattleMove) -> bool: return move.category == category)
	assert(_movesFromCategory.size() > 0, "Can't find any move from category " + str(category))

	return _movesFromCategory
