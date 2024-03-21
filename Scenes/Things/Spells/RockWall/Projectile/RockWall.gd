extends Projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 0 # TODO, add raycast to bottom of stage
	$AnimationPlayer.play("Build")
	

func position_elements(pos : Vector3) -> void:
	$MeshInstance3D.position = pos
	$CollisionShape3D.position = pos

func delete():
	queue_free()
