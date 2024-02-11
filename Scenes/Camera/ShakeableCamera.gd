extends Area3D

@export var trauma := 0.0
@export var trauma_decay := 1.0

@export var camera : Camera3D
@export var max_movement := Vector3(10,10,5)

@export var noise : FastNoiseLite
@export var noise_speed := 50.0

var time := 0.0

@onready var initial_rotation := camera.rotation_degrees as Vector3

func _ready():
	$"/root/Signals".connect("camera_shake", shake_camera)
	
func shake_camera(camera_shake : CameraShake):
	trauma = camera_shake.trauma
	trauma_decay = camera_shake.trauma_decay
	max_movement = camera_shake.max_movement
	noise_speed = camera_shake.noise_speed

func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_decay, 0.0)
	
	camera.rotation_degrees.x = initial_rotation.x + max_movement.x * get_shake_intensity() * get_noise_from_seed(0)
	camera.rotation_degrees.y = initial_rotation.y + max_movement.y * get_shake_intensity() * get_noise_from_seed(1)
	camera.rotation_degrees.z = initial_rotation.z + max_movement.z * get_shake_intensity() * get_noise_from_seed(2)

func add_trauma(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
