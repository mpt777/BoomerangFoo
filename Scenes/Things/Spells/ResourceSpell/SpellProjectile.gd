extends SpellResource
class_name SpellProjectile

@export
var PROJECTILE : PackedScene

enum SPELL_TYPES {RANGE, MELEE}

@export
var spell_type : SPELL_TYPES = SPELL_TYPES.RANGE

func projectile() -> Projectile:
	return PROJECTILE.instantiate()
