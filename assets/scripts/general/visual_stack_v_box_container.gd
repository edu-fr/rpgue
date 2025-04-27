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

	var _stateObject: Node = self.get_child(0)
	self.remove_child(_stateObject)
	_stateObject.queue_free()

	return


func stack_pop() -> void:
	var childCount: int = self.get_child_count()
	assert(childCount > 0, "Can't pop stack on the visual stack if child count is zero")

	while (childCount > 0):
		pop()
		assert(childCount != self.get_child_count(), "Child text not been properly removed")
		childCount = self.get_child_count()

	return
