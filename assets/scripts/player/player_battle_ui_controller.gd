class_name PlayerBattleUIController
extends Control

@export var _statusPanel: PlayerStatusPanelController
@export var _actionsPanel: ActionsPanelController
@export var _attackMovesPanel: BattleMovesPanel
@export var _techMovesPanel: BattleMovesPanel

var _playerBattleActor: PlayerBattleActor


func init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	_playerBattleActor = playerBattleActor

	_statusPanel.init(playerBattleActor)
	_actionsPanel.init(stateMachine)

	_attackMovesPanel.init(stateMachine.on_attack_index_cliked, playerBattleActor.get_battle_moves_by_category(MoveData.Category.ATTACK))
	_techMovesPanel.init(stateMachine.on_tech_index_cliked, playerBattleActor.get_battle_moves_by_category(MoveData.Category.TECH))

	return


func start_player_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	return await _actionsPanel.start_turn(remainingEnemies)


func get_player_health() -> float:
	return _playerBattleActor.get_current_HP()


func is_player_alive() -> bool:
	return get_player_health() > 0


func hide_and_disable_actions_panel() -> void:
	_actionsPanel.hide()
	_actionsPanel.set_buttons_enabled(false)

	return


func show_and_enable_actions_panel() -> void:
	_actionsPanel.set_buttons_enabled(true)
	_actionsPanel.show()

	return


func hide_and_disable_moves_panels() -> void:
	_attackMovesPanel.hide()
	_techMovesPanel.hide()
	_attackMovesPanel.set_buttons_enabled(false)
	_techMovesPanel.set_buttons_enabled(false)

	return


func show_and_enable_selected_moves_panel(category: MoveData.Category) -> void:
	match(category):
		MoveData.Category.ATTACK:
			_show_and_enable_attack_moves_panel()
		MoveData.Category.TECH:
			_show_and_enable_tech_moves_panel()

	return


func _show_and_enable_attack_moves_panel() -> void:
	_attackMovesPanel.set_buttons_enabled(true)
	_attackMovesPanel.show()

	return


func _show_and_enable_tech_moves_panel() -> void:
	_techMovesPanel.set_buttons_enabled(true)
	_techMovesPanel.show()

	return
