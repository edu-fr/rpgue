class_name EnemyController
extends Control

@export var _healthBar: HealthProgressBarController
@export var _statusConditionPanelController: StatusConditionPanelController
@export var _enemyImage: TextureRect

var _battleActor: EnemyBattleActor


func init(enemyInstance: EnemyBattleActor) -> void:
	_battleActor = enemyInstance
	_healthBar.init(_battleActor.get_max_HP(), _battleActor.get_current_HP())
	_battleActor.current_hp_changed.connect(_healthBar.update_value)
	_battleActor.status_conditions_changed.connect(_statusConditionPanelController.update_status_conditions)

	return


func receive_player_attack(incomingBattleMove: OutgoingBattleMove) -> void:
	_alive_assertion()

	if (GM.verbose):
		print("Enemy " + str(get_id()) + " receiving attack")

	_battleActor.take_battle_move(incomingBattleMove)

	if (!is_alive()):
		_on_death()

	return


func heal(healValue: int) -> void:
	_alive_assertion()

	_battleActor.heal(healValue)

	return


func set_selected(value: bool) -> void:
	if (!is_alive()):
		push_error("Trying to set an dead enemy selection to " + str(value))
		return

	_enemyImage.modulate = Color(1.5, 1.5, 1.5) if value else Color(1, 1, 1)

	return


func set_semi_selected(value: bool) -> void:
	if (!is_alive()):
		push_error("Trying to set an dead enemy semi selection to " + str(value))
		return

	_enemyImage.modulate = Color(1.3, 1.3, 1.3) if value else Color(1, 1, 1)

	return


func is_alive() -> bool:
	return _battleActor.alive()


func get_random_move() -> BattleMove:
	return _battleActor.get_random_move()


func get_id() -> int:
	return _battleActor._id


func get_battle_actor() -> EnemyBattleActor:
	assert(_battleActor != null, "Enemy controller battle actor is null")

	return _battleActor


func _on_death() -> void:
	# Death animation
	_enemyImage.visible = false
	_healthBar.visible = false
	_statusConditionPanelController.clear_status_conditions()
	_statusConditionPanelController.hide_panel()

	if (GM.verbose):
		print("Enemy " + str(get_id()) + " has died")

	return


func _alive_assertion() -> void:
	assert(is_alive(), "Dead enemies should't execute any action")
