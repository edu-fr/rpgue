class_name EnemyZombie
extends EnemyBattleActor

func _init() -> void:
	var __maxHP: float = 50
	var __currentHP: float = 50
	var __attackDamage: float = 15
	var __moveList: Array[BattleMove]

	super(__maxHP, __currentHP, __attackDamage, __moveList)

	return

func _get_move_list() -> Array[BattleMove]:
	## IMPORTAR DO GOOGLE SHEETS O MOVE QUE DA POISON, E TAMBEM JA IMPORTAR O INIMIGO