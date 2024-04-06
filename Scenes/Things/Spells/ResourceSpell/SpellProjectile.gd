extends SpellResource
class_name SpellProjectile

@export
var PROJECTILE : PackedScene

enum SPELL_TYPES {RANGE, MELEE}

@export
var spell_type : SPELL_TYPES = SPELL_TYPES.RANGE

var DEFAULT_PROJECTILE := preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")
var DEFAULT_MELEE_PROJECTILE := preload("res://Scenes/Things/Spells/RockWall/Projectile/RockWall.tscn")

func projectile() -> Projectile:
	return PROJECTILE.instantiate()
