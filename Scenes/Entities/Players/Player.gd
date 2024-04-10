extends StandardCharacter

class_name Player

@onready
var n_movement := $Movement

@onready
var controller : Controller

var rotation_speed := 10.0

# Called when the node enters the scene tree for the first time.

func constructor(player_data : PlayerData):
	data = player_data
	controller = data.controller
	#$MeshInstance3D.mesh.material = StandardMaterial3D.new()
	#$MeshInstance3D.mesh.material.albedo_color = player_data.color
	
func _ready():
	super._ready()
	signals.emit_signal("Wand.ChangeSpell", data.range_spell)
	signals.emit_signal("Wand.ChangeSpell", data.melee_spell)
	#n_wand.change_spell(data.range_spell)
	#n_wand.change_spell(data.melee_spell)
	
func _physics_process(delta):
	rotate_character(delta)
	n_movement.move(get_input_direction())
	
func get_input_direction() -> Vector3:
	var direction := Vector3.ZERO
	var axis := Input.get_vector(
		controller.action("move_left"), 
		controller.action("move_right"), 
		controller.action("move_up"),
		controller.action("move_down")
	)
	direction.x = axis.x
	direction.z = axis.y
	return direction.normalized()
	
func _input(event):
	#if event.is_action_pressed(controller.action("thow_weapon")):
		#n_hand.throw()
	if event.is_action_pressed(controller.action("attack_range")):
		#n_hand.use("range")
		signals.emit_signal("Wand.Attack", "range")
	if event.is_action_pressed(controller.action("attack_melee")):
		#n_hand.use("melee")
		signals.emit_signal("Wand.Attack", "melee")
	if event.is_action_pressed(controller.action("dash")):
		signals.emit_signal("Movement.dash")
		
func rotate_character(delta):
	var pos := global_position
	if controller.is_joypad:
		pos = get_look_position()
	else:
		pos = get_mouse_position()
	if pos == global_position:
		pos = velocity.normalized() * 10000
	if pos != Vector3.ZERO && abs(pos.x) > 0.99 && pos != global_position:
		target_position = pos
		var new_transform = transform.looking_at(pos, Vector3.UP)
		transform = transform.interpolate_with(new_transform, rotation_speed * delta) 
		#signals.emit_signal("Rotate", pos)
	rotation.x = 0
	
func get_look_position() -> Vector3:
	var pos := Input.get_vector(
			controller.action("look_left"), 
			controller.action("look_right"), 
			controller.action("look_up"),
			controller.action("look_down")
	) * 100000
	return Vector3(global_position.x + pos.x, global_position.y, global_position.z + pos.y) 
	
func get_mouse_position() -> Vector3:
	var camera = get_tree().get_nodes_in_group("Camera")[0]
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 2000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = false
	ray_query.set_collision_mask(1 << 13 - 1)
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		return raycast_result.position
	return global_position

