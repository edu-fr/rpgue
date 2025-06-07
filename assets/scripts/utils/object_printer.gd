class_name ObjectPrinter
extends RefCounted

static func print_object(obj: Object) -> String:
	var output: String = ""
	var properties: Array = obj.get_property_list()
	var script_enums: Dictionary = {}

	if obj.get_script() is Script:
		var script_ref: Script = obj.get_script()
		script_enums = script_ref.get_script_constant_map()

	for property: Dictionary in properties:
		if not (property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE):
			continue

		var property_name: String = property["name"]

		if property_name.begins_with("_"):
			continue

		var value: Variant = obj.get(property_name)

		if value == null:
			continue

		output += property_name + " = " + _format_value(value, script_enums) + "\n"

	return output


static func _format_value(value: Variant, script_enums: Dictionary) -> String:
	if value is Array:
		var formatted_array: Array[String] = []
		for item: Variant in value:
			formatted_array.append(_format_single_value(item, script_enums))
		return "[" + ", ".join(formatted_array) + "]"

	return _format_single_value(value, script_enums)


static func _format_single_value(value: Variant, script_enums: Dictionary) -> String:
	if value is int:
		for enum_name: String in script_enums:
			var enum_dict: Dictionary = script_enums[enum_name]
			if enum_dict is Dictionary and enum_dict.has("__enum__"):
				for key: String in enum_dict:
					if key != "__enum__" and enum_dict[key] == value:
						return key

	return str(value)