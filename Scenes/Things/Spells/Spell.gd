extends Resource
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
	a.character = weapon.weapon_owner.data
	return a
	
func initialize_projectile(weapon: Weapon) -> Projectile:
	var p := projectile()
	p.position = weapon.global_position
	p.rotation = weapon.global_rotation
	p.attack = attack(weapon)
	return p
	
func cast(weapon: Weapon) -> void:
	weapon.get_node("/root/Signals").emit_signal("add_projectile", initialize_projectile(weapon))
