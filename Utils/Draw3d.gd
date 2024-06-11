extends Node
class_name Draw3D

# Called when the node enters the scene tree for the first time.
var points := []
var color = Color.WHITE_SMOKE
var mesh_instance : MeshInstance3D

func _ready():
	self.name="Draw3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func add_point(pos : Vector3) -> void:
	points.append(pos)
#	if points.size() > 1:
#		#Draw a line from the position of the last point placed to the position of the second to last point placed
#		var point1 = points[points.size()-1]
#		var point2 = points[points.size()-2]
#		var line = line(point1, point2)
#		lines.append(line)

func reset() -> void:
	points = []
	if mesh_instance:
		mesh_instance.queue_free()
		
func draw_line() -> MeshInstance3D:
	mesh_instance = MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP, material)
	
	for i in range(points.size()):
		if i + 1 < points.size():
			var A = points[i]
			immediate_mesh.surface_add_vertex(A)
		
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	add_child(mesh_instance)
	
	return mesh_instance
	

#func line(pos1: Vector3, pos2: Vector3, color = Color.WHITE_SMOKE) -> MeshInstance3D:
#	var mesh_instance := MeshInstance3D.new()
#	var immediate_mesh := ImmediateMesh.new()
#	var material := ORMMaterial3D.new()
#
#	mesh_instance.mesh = immediate_mesh
#	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
#
#	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
#	immediate_mesh.surface_add_vertex(pos1)
#	immediate_mesh.surface_add_vertex(pos2)
#	immediate_mesh.surface_end()
#
#	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
#	material.albedo_color = color
#
#	add_child(mesh_instance)
#
#	return mesh_instance
