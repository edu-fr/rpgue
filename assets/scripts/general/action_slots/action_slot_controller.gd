class_name ActionSlotController
extends Panel

const font_scale_factor: float = 0.05

@export var panelContainer: PanelContainer
@export var moveLabel: Label

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

	resized.connect(_on_painel_resized)
	_on_painel_resized()

	return


func _on_painel_resized() -> void:
	if moveLabel:
		var novo_tamanho_fonte: float = self.size.x * font_scale_factor
		moveLabel.add_theme_font_size_override("font_size", int(novo_tamanho_fonte))

	return


func setup(type: Action.ActionSlotType) -> void:
	remove_move()
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


func add_move(battleMove: BattleMove) -> void:
	assert(currentActiveBattleMove == null, "Trying to add a move to an action slot that is already occupied")

	currentActiveBattleMove = battleMove
	moveLabel.text = battleMove.publicName

	# TODO: Add special effect if the move type matches the slot type

	return


func remove_move() -> void:
	currentActiveBattleMove = null
	moveLabel.text = ""

	return


func set_active(boolean: bool) -> void:
	active = boolean
	self.set_visible(boolean)

	return

