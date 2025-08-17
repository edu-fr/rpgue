class_name PlayerBattleActor
extends BattleActor

var actionSlots: int

func _init(id: int, maxHP: float, currentHP: float, currentAttackDamageMultiplier: float, moveList: Array[String], actionSlotsAmount: int) -> void:
	super(id, maxHP, currentHP, currentAttackDamageMultiplier, moveList)
	actionSlots = actionSlotsAmount

	return
