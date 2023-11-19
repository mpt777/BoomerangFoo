extends Controller

@export
var target : CharacterBody3D

@export
var SPEED := 10

@export
var ACCELERATION := 0.8

@export
var FRICTION := 0.5

@export
var GRAVITY := 9.8

signal MouseMovement

# Called when the node enters the scene tree for the first time.
func _ready():
	register_action("move_up", InputEventKey.new(), KEY_W)
	register_action("move_down", InputEventKey.new(), KEY_S)
	register_action("move_left", InputEventKey.new(), KEY_A)
	register_action("move_right", InputEventKey.new(), KEY_D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if not target:
		return
	# We create a local variable to store the input direction.
	var direction := Vector3.ZERO
	var target_velocity := Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	direction.x = Input.get_axis(action("move_left"), action("move_right"))
	direction.z = Input.get_axis(action("move_up"),action("move_down"))
	direction = direction.normalized() * SPEED
	
	if direction.length() > 0:
		target.velocity = target.velocity.lerp(direction, ACCELERATION)
	else:
		target.velocity = target.velocity.lerp(Vector3.ZERO, FRICTION)
		
	target.velocity.y -= GRAVITY

	target.move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion:
		var pos = mouse_position()
		if pos:
			emit_signal("MouseMovement", pos)
		
func mouse_position():
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 2000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		return raycast_result.position
