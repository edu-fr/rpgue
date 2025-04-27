class_name BaseStateMachine

var stateStack: Stack
signal statePushed(state_name: String)
signal statePop()
signal stackPop()

var currentState: BaseState:
	get:
		return stateStack.peek() if stateStack and not stateStack.is_empty() else null
	set(value):
		push_error("Readonly property")


func _init() -> void:
	stateStack = Stack.new()

	return


func push_state(newState: BaseState) -> void:
	_assert_state_type(newState)

	if (currentState != null):
		currentState.on_state_end()

	stateStack.push(newState)

	statePushed.emit(Utils.get_clear_script_name(newState))
	print("After push: New current state: " + str(Utils.get_clear_script_name(currentState)))
	currentState.on_state_start()

	return


func pop_state(resumeCurrent: bool = true) -> void:
	currentState.on_state_end()

	stateStack.pop()
	statePop.emit()

	if (resumeCurrent):
		currentState.on_state_resumed()

	if (currentState != null):
		print("After pop: New current state: " + str(Utils.get_clear_script_name(currentState)))

	return


func swap_state(newState: BaseState) -> void:
	_assert_state_type(newState)

	pop_state(false)
	push_state(newState)

	return


func pop_stack(newBaseState: BaseState) -> void:
	_assert_state_type(newBaseState)

	currentState.on_state_end()
	stateStack.clear()
	stackPop.emit()
	push_state(newBaseState)

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
