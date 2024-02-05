extends Spell
class_name RockWallSpell

const PROJECTILE := preload("res://Scenes/Things/Spells/RockWall/Projectile/RockWall.tscn")

func _ready():
	pass

func spell_type() -> SPELL_TYPES:
	return SPELL_TYPES.MELEE
	
func projectile() -> Projectile:
	return PROJECTILE.instantiate()
