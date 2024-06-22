extends SpellCast
class_name EarthquakeSpellCastOld

var RADIUS = 5
var AMOUNT = 5

func random_point_in_radius() -> Vector3:
	var theta = randf() * 2.0 * PI
	var r = sqrt(randf()) * RADIUS
	var x = r * cos(theta)
	var y = r * sin(theta)
	return Vector3(x, 0, y)

func instance_projectiles(spell: ResourceSpell, weapon : Weapon) -> void:
	var count : int = spell.stats.get_value("p.count", 1)

	for i in range(count * AMOUNT):
		var bullet := spell.projectile()
		
		bullet.position = weapon.spawn_node().global_position + random_point_in_radius()
		bullet.position.y = 0
		
		bullet.data.SPEED = 0

		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
		bullet.set_character_data(weapon.weapon_owner.data)
