extends Modifier
class_name SpellProjectile

@export var PROJECTILE : PackedScene
@export var spell_cast : SpellCast

func add(stat : Stat):
	super(stat)
	stat.clear_modifiers()
	stat.value = self

func projectile() -> Projectile:
	return PROJECTILE.instantiate()
