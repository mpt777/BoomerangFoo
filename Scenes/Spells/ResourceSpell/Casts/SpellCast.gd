extends Resource
class_name SpellCast

func instance_projectiles(spell: ResourceSpell, weapon : Weapon) -> void:
	var count : int = spell.stats.get_value("p.count", 1)
	var bullet_speed : float = spell.stats.get_value("p.speed", 1)
	
	var spread_angle_degrees = 20
	var start_angle = -spread_angle_degrees / 2.0
	var angle_increment = spread_angle_degrees / (count - 1.0)

	
	for i in range(count):
		var bullet := spell.projectile()
		
		bullet.position = weapon.spawn_node().global_position
		bullet.position.y = 1 
		bullet.rotation = weapon.spawn_node().global_rotation
		bullet.set_character_data(weapon.weapon_owner.data)
		bullet.data.SPEED *= bullet_speed

		if count > 1:
			bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))

		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
