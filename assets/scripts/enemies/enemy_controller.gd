class_name EnemyController
extends Control

@export var _healthBar: HealthBarController
@export var _enemyImage: TextureRect

var _enemyAttackPower : int
var _enemyHealPower : int
var rewardCoinsAmount : int

func init() -> void:
	_setup_health_bar(50)
	_enemyAttackPower = 10
	_enemyHealPower = 5
	rewardCoinsAmount = 10

	return


func act() -> EnemyAction:
	var rng   = RandomNumberGenerator.new()
	var value = rng.randi_range(1, 2)

	assert(value == 1 or value == 2)

	match value:
		1:
			return _attackAction()
		2:
			return _healAction()

	return null


func on_damage_received(damage: int) -> void:
	_take_damage(damage)

	if (!_healthBar.alive()):
		print("morri")

	return


func heal(healValue: int) -> void:
	_healthBar.heal(healValue)

	return


func set_selected(value: bool) -> void:
	_enemyImage.modulate = Color(1.5, 1.5, 1.5) if value else Color(1, 1, 1)

	return


func is_alive() -> bool:
	return _healthBar.alive()


func _setup_health_bar(maxHealth: int, current: int = -1) -> void:
	_healthBar.init(maxHealth, current)

	return


func _take_damage(damageValue: int) -> void:
	_healthBar.take_damage(damageValue)

	return


func _attackAction() -> EnemyAction:
	# Do attack animation & SFX
	# Actions that affect other actors are applied outside of this script

	return EnemyAction.new(EnemyAction.EnemyActionCategory.ATTACK, _enemyAttackPower)


func _healAction() -> EnemyAction:
	# Do heal anim & SFX

	return EnemyAction.new(EnemyAction.EnemyActionCategory.HEAL, _enemyHealPower)
