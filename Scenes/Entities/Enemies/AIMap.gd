extends Resource
class_name AIMap

## To give some general functions that states can use to understand the world around the Enemy

var character : Enemy
const distance_bounds = Vector2(10, 30)
var decision_level : int = 0

func constructor(p_character) -> AIMap:
	self.character = p_character
	return self
	

func reset_decision_level() -> void:
	self.decision_level = 0
	
func set_decision_level(level : int) -> void:
	self.decision_level = level
	
func decide(level) -> bool:
	return level > self.decision_level
	


func pick_random_direction() -> Vector3:
	return Vector3(randf_range(-1, 1), 0, randf_range(-1,1)).normalized()

func pick_point_around_player(distance : float) -> Vector3:
	if not character.target_player:
		return Vector3.ZERO
	return character.target_player.global_position + (pick_random_direction() * distance)

func pick_random_position() -> Vector3:
	var map : RID = character.get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_random_point(map, 1, false)

func position_in_map(desired_position: Vector3) -> Vector3:
	var map : RID = character.get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_closest_point(map, desired_position)
	
func is_wrong_distance_to_player() -> bool:
	var distance : float = abs(character.global_position.distance_to(character.target_player.global_position))
	return distance < distance_bounds.x or distance > distance_bounds.y

func update_target_direction() -> void:
	character.target_direction = (character.n_nav.get_next_path_position() - character.global_position).normalized()
	
func random_position() -> Vector3:
	var method = 2
	var position := Vector3.ZERO 
	if method == 0:
		position = character.ai_map.pick_random_position()
	if method == 1:
		position = character.ai_map.pick_point_around_player(12)
	if method == 2:
		position = character.ai_map.pick_point_around_player(20)
	return position
