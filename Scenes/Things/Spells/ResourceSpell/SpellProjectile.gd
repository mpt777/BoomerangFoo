extends SpellResource
class_name SpellProjectile

enum SPELL_TYPES {RANGE, MELEE}

@export var PROJECTILE : PackedScene
@export var spell_type : SPELL_TYPES = SPELL_TYPES.RANGE

func projectile() -> Projectile:
	return PROJECTILE.instantiate()
