extends Node
class_name CameraShake

var trauma := 1.0
var trauma_decay := 1.0
var max_movement := Vector3(10,10,5)
var noise_speed := 50.0

func _init(trauma := 1.0, trauma_decay := 1.0, max_movement := Vector3(5,5,3), noise_speed := 50.0):
	self.trauma = trauma
	self.trauma_decay = trauma_decay
	self.max_movement = max_movement
	self.noise_speed = noise_speed
