class_name ImprovementManager

func get_random_upgrades(amount: int) -> Array[UpgradeData]:
	var upgrades: Dictionary = GM.dataManager.get_upgrades_data()
	var randomUpgrades: Dictionary = Utils.get_random_elements(upgrades, amount)
	var upgradeDatas: Array[UpgradeData]
	for data: UpgradeData in randomUpgrades.values():
		upgradeDatas.append(data)

	return upgradeDatas


func get_random_moves(amount: int) -> Array[MoveData]:
	var moves: Dictionary = GM.dataManager.get_moves_data()
	var randomMoves: Dictionary = Utils.get_random_elements(moves, amount)
	var movesDatas: Array[MoveData]
	for data: MoveData in randomMoves.values():
		movesDatas.append(data)

	return movesDatas