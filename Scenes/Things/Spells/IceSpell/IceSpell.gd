extends Spell
class_name IceSpell

const PROJECTILE := preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")

func _ready():
	cost = 0

	
func projectile() -> Projectile:
	return PROJECTILE.instantiate()
