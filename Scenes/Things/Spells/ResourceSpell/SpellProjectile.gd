extends SpellResource
class_name SpellProjectile

const PROJECTILE := preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")

func projectile() -> Projectile:
	return PROJECTILE.instantiate()
