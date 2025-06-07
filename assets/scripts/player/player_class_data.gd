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
	var _privateName: String = data.get("PRIVATE NAME", "")
	var _name: String = data.get("NAME", "")
	var _description: String = data.get("DESCRIPTION", "")
	var _baseDamage: float = float(str(data.get("BASE DAMAGE", 0.0)))
	var _baseBlock: float = float(str(data.get("BASE BLOCK", 0.0)))
	var _baseMaxHP: float = float(str(data.get("BASE MAX HP", 0.0)))
	var _moves: Array = data.get("INITIAL MOVE LIST", [])  # INITIAL MOVE LIST as in the .json

	return PlayerClassData.new(_privateName, _name, _description, _baseDamage, _baseBlock, _baseMaxHP, _moves)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
