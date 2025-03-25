class_name Utils
extends Node

## GENERAL UTILS

static func dev_only(func_ref: Callable) -> void:
	if OS.is_debug_build(): # Verifica se é uma build de debug
		func_ref.call()


## DICT UTILS

static func get_random_elements(original_dict: Dictionary, quantity: int) -> Dictionary:
	var result: Variant = {}

	if original_dict.is_empty() || quantity <= 0:
		return result

	# Garante que não pedimos mais elementos do que existem
	var max_elements: int = mini(quantity, original_dict.size())

	# Cria array de chaves e embaralha
	var keys: Array = original_dict.keys()
	keys.shuffle()

	# Seleciona os primeiros X elementos
	for i: int in range(max_elements):
		var key: String = keys[i]
		result[key] = original_dict[key]

	return result


## INPUT UTILS

static var _key_actions: Dictionary = {}
static var _is_debug: bool = OS.is_debug_build()
static var _validation_done: bool = false


# Configura uma ação para uma tecla
static func set_key_action(key: Key, action: Callable, one_shot: bool = false) -> void:
	if not _is_debug:
		return

	print("key SET")
	_key_actions[key] = { "action": action, "one_shot": one_shot, "executed": false    }

	return


# Remove a ação de uma tecla
static func remove_key_action(key: Key) -> void:
	if not _is_debug:
		return
	print("key removed")

	_key_actions.erase(key)

	return


static func _check_key_actions() -> void:
	if not _is_debug:
		return

	# Validação única durante a primeira execução
	if not _validation_done:
		assert(_key_actions != null, "Key actions dictionary not initialized")
		_validate_key_actions()
		_validation_done = true

	for key: Key in _key_actions:
		var key_data: Dictionary = _key_actions[key]
		var is_pressed: bool = Input.is_key_pressed(key)

		if is_pressed:
			_handle_key_press(key_data)
		else:
			key_data["executed"] = false

	return


static func _validate_key_actions() -> void:
	for key: Key in _key_actions:
		var key_data: Dictionary = _key_actions[key]
		assert(key_data.has("action") && key_data["action"] is Callable,
		"Invalid action for key %d. Requires Callable." % key)
		assert(key_data.has("one_shot"),
		"Missing 'one_shot' flag for key %d" % key)
		if key_data["one_shot"]:
			assert(key_data.has("executed"),
			"Missing 'executed' flag for one_shot key %d" % key)


static func _handle_key_press(key_data: Dictionary) -> void:
	if key_data["one_shot"]:
		if not key_data["executed"]:
			_execute_action(key_data)
			key_data["executed"] = true
	else:
		_execute_action(key_data)


static func _execute_action(key_data: Dictionary) -> void:
	var action: Callable = key_data["action"]
	if action.is_valid():
		action.call()
	else:
		push_error("Invalid Callable in key action")