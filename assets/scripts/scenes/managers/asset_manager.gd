class_name AssetManager
extends Node

const baseAssetsPath: String = "res://assets/"
const imageExtension: String = ".png"
const prefabExtension: String = ".tscn"
#-------------------------------------------------------------------------------
# Status Condition
#-------------------------------------------------------------------------------

# ICONS

const statusConditionIconsPath: String = baseAssetsPath + "art/icons/status_condition/"
# Manter sincronizado com nome do arquivo e com o enum StatusConditionType
const poisonIconPath: String = statusConditionIconsPath + "poison" + imageExtension
const burnIconPath: String = statusConditionIconsPath + "burn" + imageExtension
const genericBuffIconPath: String = statusConditionIconsPath + "generic_buff" + imageExtension
const attackPowerIconPath: String = statusConditionIconsPath + "attack_power" + imageExtension
const attackSpeedIconPath: String = statusConditionIconsPath + "attack_speed" + imageExtension
const defenseIconPath: String = statusConditionIconsPath + "defense" + imageExtension
# CONTROLLERS

const statusConditionControllerPath: String = baseAssetsPath + "prefabs/UI/status_condition_controller" + prefabExtension


# METHODS

static func load_status_condition_icon(type: StatusConditionEnums.Type) -> Texture2D:
	return load_texture(_get_status_condition_icon_path_by_type(type))


static func load_status_condition_controller() -> StatusConditionController:
	var statusConditionController: StatusConditionController = preload(statusConditionControllerPath).instantiate()
	return statusConditionController


static func _get_status_condition_icon_path_by_type(type: StatusConditionEnums.Type) -> String:
	match (type):
		StatusConditionEnums.Type.POISON:
			return poisonIconPath
		StatusConditionEnums.Type.BURN:
			return burnIconPath
		StatusConditionEnums.Type.ATTACK_POWER_BUFF:
			return attackPowerIconPath
		StatusConditionEnums.Type.ATTACK_SPEED_BUFF:
			return attackSpeedIconPath
		StatusConditionEnums.Type.DEFENSE:
			return defenseIconPath
		_:
			push_error("Status condition type unknown: " + str(type))
			return ""


#-------------------------------------------------------------------------------
# Generic methods
#-------------------------------------------------------------------------------

static func load_texture(path: String) -> Texture2D:
	var texture: Texture2D = load(path) as Texture2D
	if texture == null:
		push_error("Falha ao carregar textura: " + path)

	return texture


static func resource_exists(path: String) -> bool:
	return FileAccess.file_exists(path)