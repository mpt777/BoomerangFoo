extends State

@export
var body : CharacterBody3D = null
@export
var movement : Movement

const OFFSET := 5

const distance_bounds = Vector2(10, 30)
const distance_desired = 20

var too_close := false

func select_new_position() -> void:
	var method := randi_range(0,2)
	var position := Vector3.ZERO 
	if method == 0:
		position = body.pick_random_position()
	if method == 1:
		position = pick_point_around_player(3)
	if method == 2:
		position = pick_point_around_player(10)
		
	set_new_position(position)
	
	
func pick_random_direction() -> Vector3:
	return Vector3(randf_range(0,1), 0, randf_range(0,1)).normalized()


func pick_point_around_player(distance : float) -> Vector3:
	return body.target_player.global_position + (body.target_player.global_position.direction_to(pick_random_direction()) * distance)

func position_in_map(desired_position: Vector3) -> Vector3:
	var map : RID = body.get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_closest_point(map, desired_position)
	
func set_new_position(desired_position: Vector3) -> void:
	body.n_nav.target_location = desired_position
	
	
func is_wrong_distance_to_player() -> bool:
	var distance : float = abs(body.global_position.distance_to(body.target_player.global_position))
	return distance < distance_bounds.x or distance > distance_bounds.y
	

func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	if body.velocity == Vector3.ZERO:
		select_new_position()
	if abs(body.global_position.distance_to(body.n_nav.target_location)) < 2:
		select_new_position()
	
		
func physics_update(_delta : float):
	body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	movement.move(body.target_direction)
	
	if body.target_player:
		body.n_hand.target_position = body.target_player.global_position
		body.n_hand.attack()

func _on_navigation_agent_3d_target_reached():
	select_new_position()
