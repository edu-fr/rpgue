class_name VisualStackTextMarginContainer
extends MarginContainer

@export var _textLabel: RichTextLabel


func init(text: String) -> void:
	_textLabel.text = text

	return