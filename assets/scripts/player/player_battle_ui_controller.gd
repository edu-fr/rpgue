class_name PlayerBattleUIController
extends Control

@export var _statusPanel: PlayerStatusPanelController
@export var _inputOptionsPanel: InputOptionsPanelController
@export var _movesPanel: BattleMovesPanel

var _playerBattleActor: PlayerBattleActor


func init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	_playerBattleActor = playerBattleActor

	_statusPanel.init(playerBattleActor)
	_inputOptionsPanel.init(stateMachine)

	_movesPanel.init(stateMachine.on_attack_index_cliked, playerBattleActor.get_battle_moves_by_category(ImportUtils.Category.ATTACK))

	return


func start_player_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	return await _inputOptionsPanel.start_turn(remainingEnemies)


func get_player_health() -> float:
	return _playerBattleActor.get_current_HP()


func is_player_alive() -> bool:
	return get_player_health() > 0


func hide_and_disable_actions_panel() -> void:
	_inputOptionsPanel.hide()
	_inputOptionsPanel.set_buttons_enabled(false)

	return


func show_and_enable_actions_panel() -> void:
	_inputOptionsPanel.set_buttons_enabled(true)
	_inputOptionsPanel.show()

	return


func hide_and_disable_moves_panels() -> void:
	_movesPanel.hide()
	_movesPanel.set_buttons_enabled(false)

	return


func show_and_enable_selected_moves_panel(category: ImportUtils.Category) -> void:
	match(category):
		ImportUtils.Category.ATTACK:
			_show_and_enable_attack_moves_panel()

	return


func _show_and_enable_attack_moves_panel() -> void:
	_movesPanel.set_buttons_enabled(true)
	_movesPanel.show()

	return

