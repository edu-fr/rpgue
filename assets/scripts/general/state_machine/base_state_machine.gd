class_name BaseStateMachine

var stateStack: Stack

var currentState: BaseState:
	get:
		return stateStack.peek() if stateStack and not stateStack.is_empty() else null
	set(value):
		push_error("Readonly property")


func _init() -> void:
	stateStack = Stack.new()

	return


func push_state(state: Object) -> void:
	_assert_state_type(state)

	if (currentState != null):
		currentState.on_state_end()

	stateStack.push(state)
	currentState.on_state_start()

	return


func pop_state() -> void:
	currentState.on_state_end()

	stateStack.pop()
	currentState.resume()

	return


func swap_state(state: Object) -> void:
	_assert_state_type(state)

	currentState.on_state_end()
	stateStack.pop()
	stateStack.push(state)
	currentState.on_state_start()

	return


func _assert_state_type(state: Object) -> void:
	assert(state is BaseState, "Must be a subclass from State")

	return


func on_confirm_clicked() -> void:
	currentState.on_confirm_clicked()

	return


func on_back_clicked() -> void:
	currentState.on_back_clicked()

	return


func on_right_arrow_clicked() -> void:
	currentState.on_right_arrow_clicked()

	return


func on_left_arrow_clicked() -> void:
	currentState.on_left_arrow_clicked()

	return


func on_up_arrow_clicked() -> void:
	currentState.on_up_arrow_clicked()

	return


func on_down_arrow_clicked() -> void:
	currentState.on_down_arrow_clicked()

	return
