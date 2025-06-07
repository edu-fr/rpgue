class_name EnemyData
extends Resource

var privateName: String
var name: String
var description: String
var baseDamage: float
var baseBlock: float
var maxHP: float
var startingHP: float
var moveNameList: Array[String]
var habitat: int


func _init(_privateName: String, _name: String, _description: String, _baseDamage: float, _baseBlock: float, _maxHP: float, _startingHP: float, _moveNameList: Array[String], _habitat: int) -> void:
	privateName = _privateName
	name = _name
	description = _description
	baseDamage = _baseDamage
	baseBlock = _baseBlock
	maxHP = _maxHP
	startingHP = _startingHP
	moveNameList = _moveNameList.duplicate(true)
	habitat = _habitat

	return


static func create_from_json(data: Dictionary) -> EnemyData:
	var _privateName: String = data.get("PRIVATE NAME", "")
	var _name: String = data.get("NAME", "")
	var _description: String = data.get("DESCRIPTION", "")
	var _baseDamage: float = float(str(data.get("BASE DAMAGE", 0.0)))
	var _baseBlock: float = float(str(data.get("BASE BLOCK", 0.0)))
	var _maxHP: float = float(str(data.get("MAX HP", 0.0)))
	var _startingHP: float = float(str(data.get("STARTING HP", 0.0)))
	var _habitat: int = int(str(data.get("HABITAT", -1)))
	var _moves: Array = data.get("MOVE LIST", []) # MOVE LIST as in the .json

	return EnemyData.new(_privateName, _name, _description, _baseDamage, _baseBlock, _maxHP, _startingHP, _moves, _habitat)


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
