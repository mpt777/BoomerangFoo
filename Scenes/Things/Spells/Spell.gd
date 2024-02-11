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
	
func attack(weapon : Weapon) -> Attack:
	var a := Attack.new()
	a.damage = 1
	a.owner = weapon.weapon_owner
	return a
	
func initialize_projectile(weapon: Weapon) -> Projectile:
	var projectile := projectile()
	projectile.position = weapon.global_position
	projectile.rotation = weapon.global_rotation
	projectile.attack = attack(weapon)
	return projectile
	
func cast(weapon: Weapon) -> void:
	weapon.get_node("/root/Signals").emit_signal("add_projectile", initialize_projectile(weapon))
