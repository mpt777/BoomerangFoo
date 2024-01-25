extends CharacterBody3D

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

var target_player : CharacterBody3D = null;

	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Player")
	move_body(delta)
	move_hand()
	
func move_body(delta):
	var direction := Vector3.ZERO
	n_movement.move(direction)
	
func move_hand():
	if target_player:
		n_hand.target_position = target_player.global_position
