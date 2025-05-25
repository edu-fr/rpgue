class_name AbstractBaseStatusCondition

var _entity: LivingBeing

func _init(entity: LivingBeing) -> void:
	_entity = entity

	return


func pre_turn() -> void:
	push_error("status condition pre turn not implemented on child type")

	return


func action_phase() -> void:
	push_error("status condition action phase not implemented on child type")

	return


func post_turn() -> void:
	push_error("status condition post turn not implemented on child type")

	return