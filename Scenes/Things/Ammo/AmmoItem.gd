extends Node3D
class_name AmmoItem

var initial_rotation := 0.0
var lerp_speed = 0.1

func _physics_process(delta):
	rotation.y = lerp_angle( rotation.y, initial_rotation, lerp_speed)
	
func update_initial_rotation(initial_rotation: float) -> void:
	self.initial_rotation = initial_rotation
	
func set_mesh_position(position: float) -> void:
	$MeshInstance3D.position.z = position
	
func set_mesh_material(material: Material) -> void:
	$MeshInstance3D.mesh.material = material
