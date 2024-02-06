extends Character

class_name Player

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

@onready
var controller := Controller.new()

@onready
var data := PlayerData.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	controller = data.default_controller()
	
func _physics_process(delta):
	move_hand()
	
func get_input_direction() -> Vector3:
	var direction := Vector3.ZERO
	direction.x = Input.get_axis(controller.action("move_left"), controller.action("move_right"))
	direction.z = Input.get_axis(controller.action("move_up"), controller.action("move_down"))
	return direction.normalized()
	
func _input(event):
	if event.is_action_pressed(controller.action("thow_weapon")):
		n_hand.throw()
	if event.is_action_pressed(controller.action("attack_range")):
		n_hand.use("range")
	if event.is_action_pressed(controller.action("attack_melee")):
		n_hand.use("melee")
		
func move_hand():
	var pos = mouse_position()
	if pos:
		#n_hand.target_position = pos
		
		if pos != Vector3.ZERO && abs(pos.x) > 0.99:
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

