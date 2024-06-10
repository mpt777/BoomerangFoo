extends Resource
class_name CameraShake

var trauma := 1.0
var trauma_decay := 1.0
var max_movement := Vector3(10,10,5)
var noise_speed := 50.0

func _init(p_trauma := 0.5, p_trauma_decay := 1.0, p_max_movement := Vector3(5,5,3), p_noise_speed := 25.0):
	self.trauma = p_trauma
	self.trauma_decay = p_trauma_decay
	self.max_movement = p_max_movement
	self.noise_speed = p_noise_speed
