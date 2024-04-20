extends SpellResource
class_name SpellProjectile

enum SPELL_TYPES {RANGE, MELEE}

@export var PROJECTILE : PackedScene
@export var spell_type : SPELL_TYPES = SPELL_TYPES.RANGE

func apply(character : Character):
	if self.spell_type == SPELL_TYPES.RANGE:
		character.data.range_projectile = self
	else: 
		character.data.melee_projectile = self
	self.emit_message(character)
		
func projectile() -> Projectile:
	return PROJECTILE.instantiate()
