class_name Queue
var _elements: Array = []


func enqueue(element: Variant) -> void:
	assert(element != null, "Element can't be null")
	_elements.push_back(element)
	# print_current()
	return


func dequeue() -> Variant:
	if is_empty():
		push_error("Error: Trying to dequeue from an empty queue")
		return null as Variant
	var element: Variant = _elements.pop_front()
	# print_current()
	return element


func peek() -> Variant:
	if is_empty():
		return null as Variant
	return _elements.front()


func is_empty() -> bool:
	return _elements.is_empty()


func size() -> int:
	return _elements.size()


func clear() -> void:
	_elements.clear()
	return


func contains(element: Variant) -> bool:
	return _elements.has(element)


func force_remove_aparitions(element: Variant) -> void:
	assert(contains(element), "Trying to force remove a non-existent element")
	while (contains(element)):
		_elements.erase(element)

	return


func peek_queue_end() -> Variant:
	if is_empty():
		return null as Variant

	return _elements.back()


func print_current() -> void:
	print("Queue state")
	for i: int in _elements.size():
		print("Queue[" + str(i) + "]: " + str(_elements[i]))
	return