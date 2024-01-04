extends CharacterBody3D

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

var target_player : CharacterBody3D = null;

	
func _physics_process(delta):
	target_player = closest_player()
	move_body(delta)
	move_hand()
	
func move_body(delta):
	var direction := Vector3.ZERO
	n_movement.move(direction)
	
func move_hand():
	if target_player:
		n_hand.target_position = target_player.global_position
	
func closest_player():
	var players := get_tree().get_nodes_in_group("Player")
	var nearest : float = INF
	var closest_player : CharacterBody3D = null
	for player in players:
		var distance := global_position.distance_squared_to(players[0].global_position)
		if distance and distance < nearest:
			nearest = distance
			closest_player = player
	return closest_player
