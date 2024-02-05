extends Spell
class_name RockWallSpell

const ROCKWALL_PROJECTILE := preload("res://Scenes/Things/Spells/RockWall/Projectile/RockWall.tscn")

func _ready():
	pass

func projectile() -> Projectile:
	return ROCKWALL_PROJECTILE.instantiate()
