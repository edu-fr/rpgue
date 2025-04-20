class_name VisualStackVBoxContainer
extends VBoxContainer

const _visual_stack_text_prefab_path: String = "res://assets/prefabs/visual_stack_text.tscn"


func stack(text: String) -> void:
	var newText: VisualStackTextMarginContainer = preload(_visual_stack_text_prefab_path).instantiate()
	newText.init(text)

	self.add_child(newText)
	self.move_child(newText, 0)

	return


func pop() -> void:
	assert(self.get_child_count() > 0, "Can't pop on the visual stack if child count is zero")

	self.get_child(self.get_child_count() - 1).queue_free()

	return


func stack_pop() -> void:
	while (self.get_child_count() > 0):
		pop()

	return
