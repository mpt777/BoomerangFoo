extends CharacterBody3D
class_name Enemy

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

@onready
var n_nav := $NavigationAgent3D

var target_player : CharacterBody3D = null
var target_direction : Vector3 = Vector3.ZERO
var target_location : Vector3 = Vector3.ZERO

	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Player")
	move_hand()
	
func move_hand():
	if target_player:
		n_hand.target_position = target_player.global_position
		
func attack():
	pass
	
func pick_random_position() -> Vector3:
	var map : RID = get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_random_point(map, 1, false)
	
func current_movement_state() -> String:
	return $MovementFSM.current_state_name()
	
