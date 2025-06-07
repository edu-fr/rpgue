class_name EnemyData
extends Resource

var privateName: String
var name: String
var description: String
var baseDamage: float
var baseBlock: float
var moveList: Array
var map: int


static func create_from_json(data: Dictionary) -> EnemyData:
	var enemy: EnemyData = EnemyData.new()

	# Campos obrigatórios
	enemy.privateName = data.get("PRIVATE NAME", "")
	enemy.name = data.get("NAME", "")
	enemy.description = data.get("DESCRIPTION", "")

	# Valores numéricos
	enemy.baseDamage = data.get("BASE DAMAGE", 0.0)
	enemy.baseBlock = data.get("BASE BLOCK", 0.0)
	enemy.map = data.get("MAP", 1)

	return enemy


func _to_string() -> String:
	return ObjectPrinter.print_object(self)
