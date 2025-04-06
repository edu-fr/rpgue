class_name PlayerInstance
extends Resource

## RAW DATA, NOT CONSIDERING UPGRADES OR STATS CHANGES
@export var _baseData: PlayerBaseData
@export var _baseMaxHp: float
@export var _baseCurrentHp: float
@export var _baseDamage: float
##
@export var _moves: Dictionary


func _init() -> void:
	_baseData = PlayerBaseData.new()
	_baseMaxHp = _baseData.baseHealth
	_baseCurrentHp = _baseMaxHp
	_baseDamage = _baseData.baseDamage

	return


func get_attack_damage() -> float:
	var finalAttackDamage: float = _baseDamage
	# Apply attack damage upgrades and stats changes

	return finalAttackDamage


func get_magic_damage() -> float:
	var finalMagicDamage: float = _baseDamage
	# Apply magic damage upgrades and stats changes

	return finalMagicDamage


func get_max_hp() -> float:
	var finalMaxHP: float = _baseMaxHp
	# Apply max HP upgrades and stats changes

	return finalMaxHP


func get_current_hp() -> float:
	var finalCurrentHP: float = _baseCurrentHp
	# Apply current HP upgrades and stats changes

	return finalCurrentHP


func get_attack_moves() -> Array[BattleMove]:
	var moves: Array[BattleMove] = []
	## getting attack moves array

	return moves


func get_tech_moves() -> Array[BattleMove]:
	var moves: Array[BattleMove] = []
	## getting tech move array

	return moves
