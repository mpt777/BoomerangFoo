@tool
extends Marker3D

@export var placement : Node3D
@export var cull : Node3D

@export var instance_amount := 100
@export var seed := 1:
	get:
		return seed
	set(value):
		if rng:
			seed = value
			rng.seed = seed
		#process()
		
		
@export var run := true:
	get:
		return run
	set(value):
		run = value
		if rng:
			rng.randomize()
			seed = rng.seed
		#process()
		
		

		
var multimesh: MultiMesh
var mesh_library : MeshLibrary = preload("res://Assets/Blender/Tree/tree.meshlib")
var TREE := preload("res://Scenes/Enviroment/Decorations/Tree/Tree.tscn")
var transforms := []


var rng : RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = seed
	process()
	pass
			
func process():
	print("process")
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
			
func get_random_point(transform : Transform3D) -> Vector3:
	var scale = transform.basis.get_scale()
	return Vector3(
		rng.randf_range(transform.origin.x - (scale.x/2), transform.origin.x + (scale.x/2)),
		0,
		rng.randf_range(transform.origin.z - (scale.z/2), transform.origin.z + (scale.z/2)),
	)
	
func set_transforms():
	var transform = Transform3D()
	for i in range(instance_amount):
		transform.origin = get_random_point(placement.transform)
		transform.basis = transform.basis.rotated(Vector3(0, 1, 0), rng.randf_range(-3, 3))
		transforms.append(transform)

func process_mesh(mesh: Mesh, transform : Transform3D):
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
	
	
