extends State

@export
var body : CharacterBody3D = null

var target_player : CharacterBody3D = null;
var wander_time : float = 0.0
var target_direction : Vector3 = Vector3.ZERO

func closest_player():
	var players := get_tree().get_nodes_in_group("Player")
	var nearest : float = INF
	var closest_player : CharacterBody3D = null
	for player in players:
		var distance := body.global_position.distance_squared_to(players[0].global_position)
		if distance and distance < nearest:
			nearest = distance
			closest_player = player
	return closest_player

func random_movement():
	target_direction = Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	if wander_time < 0:
		random_movement()
	else:
		wander_time -= delta
		
	
func physics_update(_delta : float):
	target_player = closest_player()
	body.n_movement.move(target_direction)
	
	if target_player:
		body.n_hand.target_position = target_player.global_position
		
		body.n_hand.attack()
