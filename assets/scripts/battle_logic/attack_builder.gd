class_name AttackBuilder


static func create_attack(playerInstance: PlayerInstance, targetIndexes: Array[int], attackType: ATTACK_TYPE) -> BattleMove:
	var newAttack = BattleMove.new(playerInstance.get_attack_damage(), targetIndexes, attackType)

	for upgrade in playerInstance._upgrades:
		newAttack._applyUpgrade(upgrade)

	return newAttack
