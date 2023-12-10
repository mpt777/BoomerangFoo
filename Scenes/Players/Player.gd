extends CharacterBody3D

class_name Player

@onready
var n_hand := $Hand
		
@export
var SPEED := 10
@export
var ACCELERATION := 0.8
@export
var FRICTION := 0.5
@export
var GRAVITY := 9.8

@onready
var controller := Controller.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	controller.register_action("move_up", InputEventKey.new(), KEY_W)
	controller.register_action("move_down", InputEventKey.new(), KEY_S)
	controller.register_action("move_left", InputEventKey.new(), KEY_A)
	controller.register_action("move_right", InputEventKey.new(), KEY_D)
	controller.register_action("thow_weapon", InputEventKey.new(), KEY_Q)
	
func _physics_process(delta):
	move_player()
	move_hand()
	if Input.is_action_just_pressed(controller.action("thow_weapon")):
		n_hand.throw()
	
	
func move_player():
	var direction := Vector3.ZERO
	var target_velocity := Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	direction.x = Input.get_axis(controller.action("move_left"), controller.action("move_right"))
	direction.z = Input.get_axis(controller.action("move_up"), controller.action("move_down"))
	direction = direction.normalized() * SPEED
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction, ACCELERATION)
	else:
		velocity = velocity.lerp(Vector3.ZERO, FRICTION)
		
	velocity.y -= GRAVITY

	move_and_slide()
	
func _input(event):
	pass
		
func move_hand():
	var pos = mouse_position()
	if pos:
		n_hand.target_position = pos
	
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

func _on_pick_up_component_picked_up_area(area):
	n_hand.pickup(area.get_parent())
