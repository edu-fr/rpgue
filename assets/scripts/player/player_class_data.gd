class_name PlayerClassData
extends Resource

var privateName: String
var name: String
var description: String
var baseDamage: float
var baseBlock: float
var baseMaxHP: float
var initialMoveNameList: Array[String]


func _init(_privateName: String, _name: String, _description: String, _baseDamage: float, _baseBlock: float, _baseMaxHP: float, _initialMoveNameList: Array[String]) -> void:
	privateName = _privateName
	name = _name
	description = _description
	baseDamage = _baseDamage
	baseBlock = _baseBlock
	baseMaxHP = _baseMaxHP
	initialMoveNameList = _initialMoveNameList.duplicate(true)

	return


static func create_from_json(data: Dictionary) -> PlayerClassData:
	var _privateName: String = str(Utils.get_data(data, "PRIVATE NAME", "")).replace(" ", "")
	var _name: String = Utils.get_data(data, "NAME", "")
	var _description: String = Utils.get_data(data, "DESCRIPTION", "")
	var _baseDamage: float = float(str(Utils.get_data(data, "BASE DAMAGE", 0.0)))
	var _baseBlock: float = float(str(Utils.get_data(data, "BASE BLOCK", 0.0)))
	var _baseMaxHP: float = float(str(Utils.get_data(data, "BASE MAX HP", 0.0)))

	var _movesListData: String = Utils.get_data(data, "INITIAL MOVE LIST", "")  # INITIAL MOVE LIST as in the .json
	var _moves: Array[String] = []  # INITIAL MOVE LIST as in the .json
	for _move: String in _movesListData.split(",", false):
		_moves.append(_move.strip_edges())

	return PlayerClassData.new(_privateName, _name, _description, _baseDamage, _baseBlock, _baseMaxHP, _moves)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
