extends Spell
class_name IceSpell

const PROJECTILE := preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")

func _ready():
	cost = 0

	
func projectile() -> Projectile:
	return PROJECTILE.instantiate()


func cast(weapon: Weapon) -> void:
	var bullet_count = 3
	var spread_angle_degrees = 20
	var start_angle = -spread_angle_degrees / 2
	var angle_increment = spread_angle_degrees / (bullet_count - 1)

	
	for i in range(bullet_count):
		var bullet = initialize_projectile(weapon)
		bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))
		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
