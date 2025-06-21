class_name PlayerRunData

# DATA FROM PLAYER OBJECT OF THE CURRENT RUN
# THE REST OF THE DATA FROM THE RUN WILL BE IN run_data.gd
# THIS WILL PERSIST

var _id: int
var _maxHP: float
var _currentHP: float
var _initialAttackDamageMultiplier: float
var _currentAttackDamageMultiplier: float
var _moveList: Array[String]


func _init(id: int, maxHP: float, currentHP: float, initialAttackDamageMultiplier: float, currentAttackDamageMultiplier: float, moveList: Array[String]) -> void:
	_id = id
	_maxHP = maxHP
	_currentHP = currentHP
	_initialAttackDamageMultiplier = initialAttackDamageMultiplier
	_currentAttackDamageMultiplier = currentAttackDamageMultiplier
	_moveList = moveList


func update_run_data_from_battle_actor() -> void:

	return

func create_battle_actor_from_run_data() -> PlayerBattleActor:
	return PlayerBattleActor.new(_id, _maxHP, _currentHP, _currentAttackDamageMultiplier, _moveList)

