extends SpellCast
class_name EarthquakeSpellCast


func instance_projectiles(spell: ResourceSpell, weapon : Weapon) -> void:
	var count : int = spell.stats.get_value("p.count", 1)

	var bullet : EarthquakeProjectile = spell.projectile()
	bullet.radius = 3 + (0.5 * count)
	
	bullet.position = weapon.spawn_node().global_position
	bullet.position.y = 0
	
	bullet.data.SPEED = 0

	weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
	bullet.set_character_data(weapon.weapon_owner.data)
