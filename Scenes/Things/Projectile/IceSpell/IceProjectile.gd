extends Projectile
class_name IceProjectile

var has_split = false
var count = 3

func split() -> void:
	if has_split:
		return
	var spread_angle_degrees = 20
	var start_angle = -spread_angle_degrees / 2.0
	var angle_increment = spread_angle_degrees / (count - 1.0)

	
	for i in range(count):
		var bullet : IceProjectile = load(self.scene_file_path).instantiate()
		bullet.position = self.global_position
		bullet.rotation = self.global_rotation
		bullet.attack = attack
		bullet.has_split = true
		bullet.speed = self.speed

		bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))

		self.get_node("/root/Signals").emit_signal("add_projectile", bullet)
	
	queue_free()


func _on_timer_timeout():
	split()
