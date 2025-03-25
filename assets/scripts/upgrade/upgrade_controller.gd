class_name UpgradeController
extends Control

@export var button: Button
@export var titleText: RichTextLabel
@export var descriptionText: RichTextLabel

var upgradeData: UpgradeData


func init(upgrade_data: UpgradeData) -> void:
	upgradeData = upgrade_data
	_setupButton()

	return


func _setupButton() -> void:
	assert(upgradeData != null, "Can't setup buttons without setting the upgrade data")

	titleText.text = upgradeData.name
	descriptionText.text = upgradeData.description
	button.pressed.connect(onClick)

	return


func onClick() -> void:
	print("Clicked")

	return
