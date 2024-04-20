extends Node
class_name EffectRegister

var _effects = []

func register(key : String, effect: Effect, replace:=true) -> void:
	if replace:
		_effects = []
	_effects.append(effect)
	
func has_effect(effect_type) -> bool:
	for effect in _effects:
		if effect.is_type_of(effect_type):
			return true
	return false
	
func clear(key : String) -> void:
	_effects = []
