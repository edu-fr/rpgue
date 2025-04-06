class_name AttackEffect

enum EffectDamageType { NONE, VARIABLE, ABSOLUTE }
enum EffectActivationWindow { NONE, PRE_HIT, STANDARD, POST_HIT }

var damageType: EffectDamageType
var damageValue: float
var activationWindow: EffectActivationWindow


func _init(effectDamageType: EffectDamageType, effectDamageValue: float, effectActivationWindow: EffectActivationWindow) -> void:
	damageType = effectDamageType
	damageValue = effectDamageValue
	activationWindow = effectActivationWindow

	return
