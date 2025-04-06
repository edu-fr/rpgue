class_name PlayerBattleUIController
extends Control

@export var _statusPanel: PlayerStatusPanelController
@export var _actionsPanel: ActionsPanelController
@export var _attackMovesPanel: BattleMovesPanel
@export var _techMovesPanel: BattleMovesPanel


func init() -> void:
	var player: PlayerInstance = GM.runManager.currentRunDataRef.playerInstance
	_statusPanel.init(player._baseMaxHp, player._baseCurrentHp)
	_actionsPanel.init()
	_attackMovesPanel.init()
	_techMovesPanel.init()

	return


func start_player_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	return await _actionsPanel.start_turn(remainingEnemies)


func get_player_health() -> int:
	return _statusPanel.get_player_current_health()


func is_player_alive() -> bool:
	return _statusPanel.get_player_current_health() > 0


func defend() -> void:
	print("Defend")


func damage_player(damage: int) -> bool:
	_statusPanel.damage_player(damage)

	return is_player_alive()
