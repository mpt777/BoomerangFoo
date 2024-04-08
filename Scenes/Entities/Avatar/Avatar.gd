extends CollisionShape3D

@onready
var n_avatar = $Pivot/robot

@onready
var n_pivot = $Pivot

var camera : Camera3D

var original_rotation : Vector3

func _ready():
	camera = get_viewport().get_camera_3d()
	#owner.signals.register("Rotate", update_rotation)
	original_rotation = n_pivot.global_rotation
	
#func update_rotation(new_position : Vector3) -> void:	
	##print(n_avatar.global_position.direction_to(new_position))
	#n_pivot.look_at(new_position, Vector3.UP)
	##n_avatar.rotation.y = target_vector * 360
	
func _physics_process(delta):
	n_pivot.global_rotation = original_rotation
	n_avatar.rotation.y = owner.rotation.y + PI
	#n_avatar.rotation.y += 1 * delta
	#n_pivot.look_at(camera.global_position)
