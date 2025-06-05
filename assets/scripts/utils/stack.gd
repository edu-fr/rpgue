class_name Stack

var _elements: Array = []


func push(element: Variant) -> void:
	assert(element != null, "Element can't be null")

	_elements.push_back(element)

	# print_current()

	return


func pop() -> Variant:
	if is_empty():
		push_error("Error: Trying to pop in an empty stack")
		return null as Variant

	var element: Variant = _elements.pop_back()

	# print_current()

	return element


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


func print_current() -> void:
	print("Stack state")
	for i: int in _elements.size():
		print("Stack[" + str(i) + "]: " + str(_elements[i]))

	return
