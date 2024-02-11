@tool
extends Marker3D

@export var instance_amount := 100:
	set(value):
		instance_amount = value
		process_wrapper()
			
@export var seed := 1:
	set(value):
		if rng:
			seed = value
			rng.seed = seed
		process_wrapper()
			
@export var placement_size : Vector3:
	set(value):
		placement_size = value
		process_wrapper()
		render_placement_wrapper()
			
@export var cull_size : Vector3:
	set(value):
		cull_size = value
		process_wrapper()
		render_placement_wrapper()
			
@export var show_placement := true:
	set(value):
		show_placement = value
		render_placement_wrapper()
			
@export var run := true:
	set(value):
		run = value
		if Engine.is_editor_hint():
			if rng:
				rng.randomize()
				seed = rng.seed
		process_wrapper()

var multimesh : MultiMesh
var mesh_library : MeshLibrary = preload("res://Assets/Blender/Tree/tree.meshlib")
var TREE := preload("res://Scenes/Enviroment/Decorations/Tree/Tree.tscn")
var transforms := []

var rng : RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = seed
	process()
			
func process():
	clear()

	set_transforms()
	var tree := TREE.instantiate()
	for child_node in tree.get_children():
		if child_node is MeshInstance3D:
			process_mesh(child_node.mesh, child_node.transform)
		
func clear():
	transforms = []
	for child in get_children():
		if child is MultiMeshInstance3D:
			remove_child(child)
			
func get_random_point() -> Vector3:
	if not cull_size:
		return Vector3(
			rng.randf_range(transform.origin.x - (placement_size.x/2), transform.origin.x + (placement_size.x/2)),
			0,
			rng.randf_range(transform.origin.z - (placement_size.z/2), transform.origin.z + (placement_size.z/2)),
		)
	return get_random_point_culled()

func get_random_point_culled() -> Vector3:
	var cull_bounds_x = Vector2(
		transform.origin.x - (cull_size.x/2),
		transform.origin.x + (cull_size.x/2)
	)
	var cull_bounds_z = Vector2(
		transform.origin.z - (cull_size.z/2),
		transform.origin.z + (cull_size.z/2)
	)
	var x := 0.0
	var z := 0.0
	for i in range(100):
		x = rng.randf_range(transform.origin.x - (placement_size.x/2), transform.origin.x + (placement_size.x/2))
		z = rng.randf_range(transform.origin.z - (placement_size.z/2), transform.origin.z + (placement_size.z/2))
		
		if x > cull_bounds_x.x and x < cull_bounds_x.y and z > cull_bounds_z.x and z < cull_bounds_z.y:
			pass
		else:
			break
	return Vector3(x, position.y, z)
	
func set_transforms():
	var transform = Transform3D()
	for i in range(instance_amount):
		transform.origin = get_random_point()
		transform.basis = transform.basis.rotated(Vector3(0, 1, 0), rng.randf_range(-3, 3))
		transforms.append(transform)

func process_mesh(mesh: Mesh, transform : Transform3D):
	if not transforms:
		return
	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = mesh
	multimesh.instance_count = instance_amount

	# Populate the multimesh with instances
	for i in range(instance_amount): # Example: 100
		multimesh.set_instance_transform(i, transforms[i] * transform)

	# Create a MultimeshInstance3D and assign the multimesh
	var multimesh_instance = MultiMeshInstance3D.new()
	multimesh_instance.multimesh = multimesh
	add_child(multimesh_instance)

####################################################################################################

func render_placement_wrapper():
	if Engine.is_editor_hint():
		render_placement()
		
func process_wrapper():
	if Engine.is_editor_hint():
		process()
	
####################################################################################################
func render_placement():
	for child in get_children():
		if child is MeshInstance3D:
			remove_child(child)
			
	if not show_placement:
		return
			
	var mesh_instance := MeshInstance3D.new()
	var mesh = BoxMesh.new()
	var material := StandardMaterial3D.new()
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color(0.68,0.31,0.07,0.45)
	mesh.size = placement_size
	
	mesh.material = material
	mesh_instance.mesh = mesh
	add_child(mesh_instance)
	
	
	
