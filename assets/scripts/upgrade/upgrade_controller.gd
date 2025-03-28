class_name UpgradeController
extends Control

@export var button: Button
@export var titleText: RichTextLabel
@export var descriptionText: RichTextLabel

var upgradeData: UpgradeData


func init(upgrade_data: UpgradeData, onUpgradeClicked: Callable) -> void:
	upgradeData = upgrade_data
	_setupButton(onUpgradeClicked)

	return


func _setupButton(onUpgradeClicked: Callable) -> void:
	assert(upgradeData != null, "Can't setup buttons without setting the upgrade data")

	titleText.text = upgradeData.name
	descriptionText.text = upgradeData.description
	button.pressed.connect(onUpgradeClicked.bind(upgradeData))

	return
