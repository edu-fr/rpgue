class_name ImprovementController
extends Control

@export var button: Button
@export var titleText: RichTextLabel
@export var descriptionText: RichTextLabel


func init(title: String, description: String, improvementPrivateName: String, onClick: Callable) -> void:
	titleText.text = title
	descriptionText.text =description
	button.button_up.connect(onClick.bind(improvementPrivateName))

	return
