extends SpellCast
class_name SurfSpellCast

func offset(gt : Transform3D, offset : Vector3) -> Transform3D:
	gt.origin -= gt.basis * offset
	return gt
	
func rotate_offset(gt : Transform3D, degrees: float) -> Transform3D:
	gt.basis = gt.basis.rotated(Vector3(0,1,0), deg_to_rad(degrees))
	return gt

func instance_projectiles(spell: ResourceSpell, weapon : Weapon) -> void:
	var count : int = spell.stats.get_value("p.count", 1)
	#var count = 3s
	var bullet_speed : float = spell.stats.get_value("p.speed", 1)
	
	var spread_angle_degrees = 90
	
	var angle_increment = 0
	var start_angle = 0
	if count != 1:
		start_angle = -spread_angle_degrees / 2.0
		angle_increment = spread_angle_degrees / (count - 1.0)

	#spawns multiple next to eachother
	var items := 5
	var item_width := 0.5
	var total_width = items * item_width
	var start_offset = 0 - (total_width / 2) + (item_width / 2)
	
	for i in range(count):
		for w in range(items):
			var bullet := spell.projectile()
			
			var n_spawn_node = weapon.spawn_node()

			
			bullet.data.SPEED *= bullet_speed

			weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
			
			bullet.set_character_data(weapon.weapon_owner.data)
			bullet.global_position = n_spawn_node.global_position
			bullet.global_rotation = n_spawn_node.global_rotation
			
			if count > 1:
				bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))
			
			var transform = offset(n_spawn_node.global_transform, Vector3(0,0,-1))
			bullet.global_transform = offset(rotate_offset(transform, start_angle + (i * angle_increment)), Vector3(0,0,1.5))

			var x_offset = start_offset + w * item_width

			bullet.global_position += -bullet.global_transform.basis.x * x_offset
			bullet.global_position.y = 0
