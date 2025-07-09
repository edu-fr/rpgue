class_name PlayerClassData
extends Resource

var privateName: String
var name: String
var description: String
var baseDamageMultiplier: float
var baseBlockMultiplier: float
var baseMaxHP: float
var initialMoveNameList: Array[String]
var immunities: Array[StatusConditionEnums.Type]


func _init(\
	_privateName: String, \
	_name: String, \
	_description: String, \
	_baseDamageMultiplier: float, \
	_baseBlockMultiplier: float, \
	_baseMaxHP: float, \
	_initialMoveNameList: Array[String], \
	_immunities: Array[StatusConditionEnums.Type])\
-> void:
	privateName = _privateName
	name = _name
	description = _description
	baseDamageMultiplier = _baseDamageMultiplier
	baseBlockMultiplier = _baseBlockMultiplier
	baseMaxHP = _baseMaxHP
	initialMoveNameList = _initialMoveNameList.duplicate(true)
	immunities = _immunities.duplicate(true)

	return


static func create_from_json(data: Dictionary) -> PlayerClassData:
	var _privateName: String = str(Utils.get_data(data, "PRIVATE NAME", "")).replace(" ", "")
	var _name: String = Utils.get_data(data, "NAME", "")
	var _description: String = Utils.get_data(data, "DESCRIPTION", "")
	var _baseDamageMultiplier: float = float(str(Utils.get_data(data, "BASE DAMAGE MULTIPLIER", 1.0)))
	var _baseBlockMultiplier: float = float(str(Utils.get_data(data, "BASE BLOCK MULTIPLIER", 1.0)))
	var _baseMaxHP: float = float(str(Utils.get_data(data, "BASE MAX HP", 0.0)))

	var _movesListData: String = Utils.get_data(data, "INITIAL MOVE LIST", "")  # INITIAL MOVE LIST as in the .json
	var _moves: Array[String] = []  # INITIAL MOVE LIST as in the .json
	for _move: String in _movesListData.split(",", false):
		_moves.append(_move.strip_edges())

	var _immunities: Array[StatusConditionEnums.Type] = ImportUtils.parse_immunities(Utils.get_data(data, "STATUS CONDITION", []))

	return PlayerClassData.new(_privateName, _name, _description, _baseDamageMultiplier, _baseBlockMultiplier, _baseMaxHP, _moves, _immunities)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
