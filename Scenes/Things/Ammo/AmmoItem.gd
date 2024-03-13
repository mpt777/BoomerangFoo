extends Node3D


var initial_rotation := 0.0
var lerp_speed = 0.1

func _physics_process(delta):
	rotation.y = lerp_angle( rotation.y, initial_rotation, lerp_speed)
	
func update_initial_rotation(initial_rotation: float) -> void:
	self.initial_rotation = initial_rotation
