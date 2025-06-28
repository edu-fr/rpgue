class_name EnemyController
extends Control

@export var _healthBar: HealthProgressBarController
@export var _enemyImage: TextureRect

var _enemyInstance: EnemyBattleActor


func init(enemyInstance: EnemyBattleActor) -> void:
	_enemyInstance = enemyInstance
	_healthBar.init(_enemyInstance.get_max_HP(), _enemyInstance.get_current_HP())
	_enemyInstance.current_hp_changed.connect(_healthBar.update_value)

	return


func receive_player_attack(moveData: MoveData) -> void:
	_alive_assertion()

	_enemyInstance.take_damage(moveData.baseDamage)

	if (!is_alive()):
		_on_death()

	return


func heal(healValue: int) -> void:
	_alive_assertion()

	_enemyInstance.heal(healValue)

	return


func set_selected(value: bool) -> void:
	_alive_assertion()

	_enemyImage.modulate = Color(1.5, 1.5, 1.5) if value else Color(1, 1, 1)

	return


func set_semi_selected(value: bool) -> void:
	_alive_assertion()

	_enemyImage.modulate = Color(1.3, 1.3, 1.3) if value else Color(1, 1, 1)

	return


func is_alive() -> bool:
	return _enemyInstance.alive()


func get_random_move() -> BattleMove:
	return _enemyInstance.get_random_move()


func get_id() -> int:
	return _enemyInstance._id


func get_instance() -> EnemyBattleActor:
	return _enemyInstance


func _on_death() -> void:
	# Death animation
	_enemyImage.visible = false
	_healthBar.visible = false

	return


func _alive_assertion() -> void:
	assert(is_alive(), "Dead enemies should't execute any action")
