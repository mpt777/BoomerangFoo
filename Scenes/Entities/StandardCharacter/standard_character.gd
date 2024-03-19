extends Character
class_name StandardCharacter

func range_spell() -> Spell:
	return $Hand/Wand.range_spell
	
func melee_spell() -> Spell:
	return $Hand/Wand.melee_spell
