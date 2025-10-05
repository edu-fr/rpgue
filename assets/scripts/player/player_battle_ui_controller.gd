class_name PlayerBattleUIController
extends Control

@export var _statusPanel: PlayerStatusPanelController
@export var _inputOptionsPanel: InputOptionsPanelController
@export var _movesPanel: BattleMovesPanel
@export var _actionSlotsController: ActionSlotsController
@export var _confirmActionsButtonContainer: MarginContainer
@export var _confirmActionsButton: Button


var _playerBattleActor: PlayerBattleActor


func init(playerBattleActor: PlayerBattleActor, stateMachine: BattleStateMachine) -> void:
	_playerBattleActor = playerBattleActor

	_statusPanel.init(playerBattleActor)
	_inputOptionsPanel.init(stateMachine)
	_actionSlotsController.init()

	_confirmActionsButton.button_up.connect(stateMachine.on_confirm_clicked)
	hide_and_disable_confirm_actions_button()

	_movesPanel.init(stateMachine.on_attack_index_cliked, playerBattleActor.get_battle_moves_by_category(ImportUtils.Category.ATTACK))

	return


func get_player_health() -> float:
	return _playerBattleActor.get_current_HP()


func is_player_alive() -> bool:
	return get_player_health() > 0


func update_action_slots_for_turn() -> void:
	_actionSlotsController.turn_setup(_playerBattleActor)

	return


func on_move_selected(selectedBattleMove: SelectedBattleMove, actionSlotIndex: int) -> void:
	_actionSlotsController.on_move_selected(selectedBattleMove.battleMove, actionSlotIndex)

	return


func on_move_selection_canceled(actionSlotIndex: int) -> void:
	_actionSlotsController.on_move_selection_canceled(actionSlotIndex)

	return


func show_and_enable_actions_panel() -> void:
	print("inside show and enable actions panel")
	_inputOptionsPanel._set_buttons_enabled(true)
	_inputOptionsPanel.show()

	return


func hide_and_disable_actions_panel() -> void:
	print("inside hide and disable actions panel")
	_inputOptionsPanel.hide()
	_inputOptionsPanel._set_buttons_enabled(false)

	return


func _show_and_enable_moves_panel() -> void:
	_movesPanel.show()
	_movesPanel.set_buttons_enabled(true)

	return


func hide_and_disable_moves_panels() -> void:
	_movesPanel.hide()
	_movesPanel.set_buttons_enabled(false)

	return


func show_and_enable_moves_panel() -> void:
	_show_and_enable_moves_panel()

	return


func show_and_enable_confirm_actions_button() -> void:
	_confirmActionsButton.set_disabled(false)
	_confirmActionsButtonContainer.show()
	_confirmActionsButton.grab_focus()

	return


func hide_and_disable_confirm_actions_button() -> void:
	_confirmActionsButton.set_disabled(true)
	_confirmActionsButtonContainer.hide()

	return
