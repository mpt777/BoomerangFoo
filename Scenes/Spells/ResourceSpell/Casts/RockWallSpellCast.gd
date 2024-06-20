extends SpellCast
class_name RockWallSpellCast


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
	
	var spread_angle_degrees = 100
	
	var angle_increment = 0
	var start_angle = 0
	if count != 1:
		start_angle = -spread_angle_degrees / 2.0
		angle_increment = spread_angle_degrees / (count - 1.0)

	
	for i in range(count):
		var bullet := spell.projectile()
		
		var n_spawn_point := weapon.spawn_node()
		bullet.rotation = n_spawn_point.global_rotation
		bullet.position = n_spawn_point.global_position
		bullet.position.y = 1 
		
		
		bullet.data.SPEED *= bullet_speed

		var transform = offset(n_spawn_point.global_transform, Vector3(0,0,-1))
		bullet.transform = offset(rotate_offset(transform, start_angle + (i * angle_increment)), Vector3(0,0,3))

		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
		bullet.set_character_data(weapon.weapon_owner.data)
