extends CharacterBody3D
class_name Enemy

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

var target_player : CharacterBody3D = null;

	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Player")
	move_hand()
	
func move_hand():
	if target_player:
		n_hand.target_position = target_player.global_position
		

func attack():
	pass
	
	

