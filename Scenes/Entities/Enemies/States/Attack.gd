extends State

@export var body : CharacterBody3D = null

var target_player : CharacterBody3D = null;
var wander_time : float = 0.0
var target_direction : Vector3 = Vector3.ZERO


func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	pass
		
func physics_update(_delta : float):
	target_player = Utils.closest_node_in_group(body.global_position, "Character")
	
	if target_player:
		body.n_hand.target_position = target_player.global_position
		body.n_hand.attack()
		
	
