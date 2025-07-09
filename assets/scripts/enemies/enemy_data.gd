class_name EnemyData
extends Resource

var privateName: String
var name: String
var description: String
var baseDamageMultiplier: float
var baseBlockMultiplier: float
var maxHP: float
var startingHP: float
var moveNameList: Array[String]
var habitats: Array[float]
var immunities: Array[StatusConditionEnums.Type]


func _init(\
	_privateName: String, \
	_name: String, \
	_description: String, \
	_baseDamageMultiplier: float, \
	_baseBlockMultiplier: float, \
	_maxHP: float, \
	_startingHP: float, \
	_moveNameList: Array[String], \
	_habitats: Array[float], \
	_immunities: Array[StatusConditionEnums.Type])\
-> void:
	privateName = _privateName
	name = _name
	description = _description
	baseDamageMultiplier = _baseDamageMultiplier
	baseBlockMultiplier = _baseBlockMultiplier
	maxHP = _maxHP
	startingHP = _startingHP
	moveNameList = _moveNameList.duplicate(true)
	habitats = _habitats
	immunities = _immunities.duplicate(true)

	return


static func create_from_json(data: Dictionary) -> EnemyData:
	var _privateName: String = str(Utils.get_data(data, "PRIVATE NAME", "")).replace(" ", "")
	var _name: String = Utils.get_data(data, "NAME", "")
	var _description: String = Utils.get_data(data, "DESCRIPTION", "")
	var _baseDamageMultiplier: float = float(str(Utils.get_data(data, "BASE DAMAGE MULTIPLIER", 1.0)))
	var _baseBlockMultiplier: float = float(str(Utils.get_data(data, "BASE BLOCK MULTIPLIER", 1.0)))
	var _maxHP: float = float(str(Utils.get_data(data, "MAX HP", 0.0)))
	var _startingHP: float = float(str(Utils.get_data(data, "STARTING HP", 0.0)))

	var _habitatRawStr: String = Utils.get_data(data, "HABITAT", [])
	var _habitats: Array[float] = []
	for _habitat: String in _habitatRawStr.split(",", false):
		_habitats.append(float(_habitat))

	var _movesRawStr: String = Utils.get_data(data, "MOVE LIST", [])
	var _moves: Array[String] = []
	for _move: String in _movesRawStr.split(",", false):
		_moves.append(str(_move.replace(" ", "")))

	var _immunities: Array[StatusConditionEnums.Type] = ImportUtils.parse_immunities(Utils.get_data(data, "STATUS CONDITION", []))

	return EnemyData.new(\
		_privateName, \
		_name, \
		_description, \
		_baseDamageMultiplier, \
		_baseBlockMultiplier, \
		_maxHP, \
		_startingHP, \
		_moves, \
		_habitats, \
		_immunities)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)