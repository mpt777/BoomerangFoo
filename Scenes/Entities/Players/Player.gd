extends Character

class_name Player

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

@onready
var controller : Controller

@onready
var data : PlayerData

# Called when the node enters the scene tree for the first time.

func constructor(player_data : PlayerData):
	data = player_data
	controller = data.load_default_controller()
	
func _physics_process(delta):
	rotate_character()
	
func get_input_direction() -> Vector3:
	var direction := Vector3.ZERO
	var velocity := Input.get_vector(
		controller.action("move_left"), 
		controller.action("move_right"), 
		controller.action("move_up"),
		controller.action("move_down")
	)
	direction.x = velocity.x
	direction.z = velocity.y
	return direction.normalized()
	
func _input(event):
	#if event.is_action_pressed(controller.action("thow_weapon")):
		#n_hand.throw()
	if event.is_action_pressed(controller.action("attack_range")):
		n_hand.use("range")
	if event.is_action_pressed(controller.action("attack_melee")):
		n_hand.use("melee")
		
		
func rotate_character():
	var pos = null
	if controller.is_joypad:
		pos = Input.get_vector(
			controller.action("look_left"), 
			controller.action("look_right"), 
			controller.action("look_up"),
			controller.action("look_down")
		) * 100000
		pos = Vector3(global_position.x + pos.x, global_position.y, global_position.z + pos.y) 
	else:
		pos = mouse_position()
	if pos != Vector3.ZERO && abs(pos.x) > 0.99 && pos != global_position:
		look_at(pos)
	rotation.x = 0
	
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
	ray_query.collision_mask = 1 << 13 -1
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		return raycast_result.position

