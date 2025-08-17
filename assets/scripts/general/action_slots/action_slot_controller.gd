class_name ActionSlotController
extends MarginContainer

@export var panelContainer: PanelContainer

@export var PotentSlotBg: CompressedTexture2D
@export var TechSlotBg: CompressedTexture2D
@export var FastSlotBg: CompressedTexture2D
@export var UniversalSlotBg: CompressedTexture2D

var active: bool
var slotType: Action.ActionSlotType
var currentActiveBattleMove: BattleMove
var typeControllerDict: Dictionary

func _ready() -> void:
	typeControllerDict = {
		Action.ActionSlotType.POTENT: PotentSlotBg,
		Action.ActionSlotType.TECH: TechSlotBg,
		Action.ActionSlotType.FAST: FastSlotBg,
		Action.ActionSlotType.UNIVERSAL: UniversalSlotBg
	}

func setup(type: Action.ActionSlotType) -> void:
	clear()
	slotType = type
	var _themeBox: StyleBoxTexture = panelContainer.get_theme_stylebox("panel").duplicate(true)

	match type:
		Action.ActionSlotType.POTENT:
			_themeBox.texture = PotentSlotBg
		Action.ActionSlotType.TECH:
			_themeBox.texture = TechSlotBg
		Action.ActionSlotType.FAST:
			_themeBox.texture = FastSlotBg
		Action.ActionSlotType.UNIVERSAL:
			_themeBox.texture = UniversalSlotBg

	panelContainer.add_theme_stylebox_override("panel", _themeBox)

	return


func set_active(boolean: bool) -> void:
	active = boolean
	self.set_visible(boolean)

	return


func clear() -> void:
	currentActiveBattleMove = null
