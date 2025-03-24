class_name UpgradeController
extends Control

@export var button : Button

func init() -> UpgradeController:
	button.pressed.connect(onClick)

	return self


func onClick() -> void:
	print("Clicked")

	return
