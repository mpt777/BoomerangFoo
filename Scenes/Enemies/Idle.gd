extends State

@export
var body : CharacterBody3D = null
@export
var movement : Movement

const OFFSET := 5

const distance_bounds = Vector2(1, 30)
const distance_desired = 20

func select_new_position() -> void:
	if !body.target_player:
		return
	var d : Vector3 = Vector3.ZERO
	
	d = position_in_map(
		body.target_player.global_position + (body.target_player.global_position.direction_to(body.global_position) * distance_desired)
	)
	if not should_select_new_position(d):
		set_new_position(d)
		return
		
	d = position_in_map(
		Vector3(0,0,0)
	)
	
	set_new_position(d)
	

func position_in_map(desired_position: Vector3) -> Vector3:
	var map : RID = body.get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_closest_point(map, desired_position)
	
	
func set_new_position(desired_position: Vector3) -> void:
	body.n_nav.target_location = desired_position
	body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	
	
func should_select_new_position(desired_position: Vector3) -> bool:
	if not desired_position:
		return true
	var distance : float = abs(body.global_position.distance_to(desired_position))
	if distance < distance_bounds.x or distance > distance_bounds.y:
		return true
	return false

func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	if should_select_new_position(body.n_nav.target_location):
		select_new_position()
		
func physics_update(_delta : float):
	body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	movement.move(body.target_direction)

