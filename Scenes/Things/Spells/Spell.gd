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
	
func initialize_projectile(weapon: Weapon) -> Projectile:
	var bullet := projectile()
	bullet.position = weapon.global_position
	bullet.rotation = weapon.global_rotation
	bullet.weapon = weapon
	bullet.weapon_owner = weapon.weapon_owner
	return bullet
	
func cast(weapon: Weapon) -> void:
	weapon.get_node("/root/Signals").emit_signal("add_projectile", initialize_projectile(weapon))
