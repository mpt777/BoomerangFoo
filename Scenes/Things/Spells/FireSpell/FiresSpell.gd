extends Spell

class_name FireSpell

const FIRE_PROJECTILE := preload("res://Scenes/Things/Spells/FireSpell/Projectile/FireProjectile.tscn")

func _ready():
	pass

func projectile() -> Projectile:
	return FIRE_PROJECTILE.instantiate()
	
#func cast(weapon: Weapon) -> void:
	#return 
