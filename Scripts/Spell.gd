extends Node
class_name Spell

var cost := 1.0
#var projectile : Projectile
enum SPELL_TYPES {RANGE, MELEE}

func constructor() -> Spell:
	return self
	
func spell_type() -> SPELL_TYPES:
	return SPELL_TYPES.RANGE
	
func projectile() -> Projectile:
	return
	
func cast(weapon: Weapon) -> void:
	var bullet := projectile()
	bullet.position = weapon.global_position
	bullet.rotation = weapon.rotation
	bullet.weapon = weapon
	bullet.weapon_owner = weapon.weapon_owner
	weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
