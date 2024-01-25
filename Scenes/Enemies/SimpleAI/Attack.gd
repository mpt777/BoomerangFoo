extends State

@export
var body : CharacterBody3D = null

var target_player : CharacterBody3D = null;
var wander_time : float = 0.0
var target_direction : Vector3 = Vector3.ZERO



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
	target_player = Utils.closest_node_in_group(body.global_position, "Player")
	body.n_movement.move(target_direction)
	
	if target_player:
		body.n_hand.target_position = target_player.global_position
		body.n_hand.attack()
	
	return
	var closest_projectile = Utils.closest_node_in_group(body.global_position, "Projectile")
	if (closest_projectile):
		if (body.global_position.distance_squared_to(closest_projectile.global_position) < 20):
			Transitioned.emit("Dodge")
		
	
