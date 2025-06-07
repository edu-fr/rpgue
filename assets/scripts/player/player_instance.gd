class_name PlayerInstance
extends LivingBeing

func _init() -> void:
	## MOCK
	var _rawBaseData: PlayerBaseData = GM.dataManager._externalGameConfig.get_player_default_data()
	var _attackMoves: Array[MoveData] = GM.dataManager._externalGameConfig.mock_get_X_moves_of_type(MoveData.Category.ATTACK, 4)
	var _techMoves: Array[MoveData] = GM.dataManager._externalGameConfig.mock_get_X_moves_of_type(MoveData.Category.TECH, 3)

	var _playerBattleAttackMoves: Array[BattleMove]
	var _playerBattleTechMoves: Array[BattleMove];

	for i: int in _attackMoves.size():
		_playerBattleAttackMoves.append(BattleMove.new(_attackMoves[i]))

	assert(_playerBattleAttackMoves.size() > 0, "Cound't create attack battle moves")

	for j: int in _techMoves.size():
		_playerBattleTechMoves.append(BattleMove.new(_techMoves[j]))

	assert(_playerBattleTechMoves.size() > 0, "Cound't create tech battle moves")

	var _totalMoves: Array[BattleMove]
	_totalMoves.append_array(_playerBattleAttackMoves.duplicate(true))
	_totalMoves.append_array(_playerBattleTechMoves.duplicate(true))

	assert(_totalMoves.size() > 0, "Couldn't create player total battle moves array")

	super(_rawBaseData.baseHealth, _rawBaseData.baseHealth, _rawBaseData.baseDamage, _totalMoves)

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
