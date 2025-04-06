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

	## MOCK
	var _moves: Dictionary[String, MoveData] = GM.dataManager._externalGameConfig._movesRawConfig
	var _attackMoves: Array[MoveData] = _moves.values().filter(\
		func(x: MoveData) -> Array[MoveData]: return x.Category.values()[x.category] == MoveData.Category.ATTACK)
	var _techMoves: Array[MoveData] = _moves.values().filter(\
		func(x: MoveData) -> Array[MoveData]: return x.Category.values()[x.category] == MoveData.Category.TECH)	

	var _playerBattleAttackMoves: Array[BattleMove]
	var _playerBattleTechMoves: Array[BattleMove]
	
	for i: int in 4:
		var _chooseAttackMove: MoveData = _attackMoves.get(i)
		_playerBattleAttackMoves.append(BattleMove.new(_chooseAttackMove, player))

		var _chooseTechMove: MoveData = _techMoves.get(i)
		_playerBattleTechMoves.append(BattleMove.new(_chooseTechMove, player))
	##

	_attackMovesPanel._init(_playerBattleAttackMoves)
	_techMovesPanel._init(_playerBattleTechMoves)

	return


func start_player_turn(remainingEnemies: Array[EnemyController]) -> PlayerAction:
	return await _actionsPanel.start_turn(remainingEnemies)


func get_player_health() -> int:
	return _statusPanel.get_player_current_health()


func is_player_alive() -> bool:
	return _statusPanel.get_player_current_health() > 0


func damage_player(damage: int) -> bool:
	_statusPanel.damage_player(damage)

	return is_player_alive()
