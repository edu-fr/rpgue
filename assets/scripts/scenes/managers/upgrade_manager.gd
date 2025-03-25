class_name UpgradeManager
extends Node

func get_random_upgrades(amount: int) -> Array[UpgradeData]:
	var upgrades: Dictionary = GM.dataManager.get_upgrades_data()
	var randomUpgrades: Dictionary = Utils.get_random_elements(upgrades, amount)
	var upgradeDatas: Array[UpgradeData]
	for data: UpgradeData in randomUpgrades.values():
		upgradeDatas.append(data)

	return upgradeDatas
