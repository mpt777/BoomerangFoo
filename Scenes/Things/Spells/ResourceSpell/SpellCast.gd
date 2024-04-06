extends SpellResource
class_name SpellCast

@export
var count : int = 1

func process(spell : Spell, weapon : Weapon):
	
	var spread_angle_degrees = 20
	var start_angle = -spread_angle_degrees / 2.0
	var angle_increment = spread_angle_degrees / (count - 1.0)

	
	for i in range(count):
		var bullet := spell.projectile()
		
		bullet.position = weapon.global_position
		bullet.rotation = weapon.global_rotation
		bullet.attack = spell.attack(weapon)

		if count > 1:
			bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))

		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
