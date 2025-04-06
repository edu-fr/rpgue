class_name Stack


var _elements: Array = []


func push(element) -> void:
	assert(element != null, "Element can't be null")

	_elements.append(element)

	return


func pop() -> Variant:
	if is_empty():
		push_error("Error: Trying to pop in an empty stack")
		return null as Variant

	return _elements.pop_back()


func peek() -> Variant:
	if is_empty():
		return null as Variant

	return _elements.back()


func is_empty() -> bool:
	return _elements.is_empty()


func size() -> int:
	return _elements.size()


func clear() -> void:
	_elements.clear()

	return
