extends State

@export
var body : CharacterBody3D = null

var target_player : CharacterBody3D = null;
var wander_time : float = 0.0
var target_direction : Vector3 = Vector3.ZERO


func random_movement():
	target_direction = Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized()
	wander_time = randf_range(1, 3)
	if wander_time > 2.6:
		Transitioned.emit(self, "Dash")

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
	body.n_movement.move(target_direction)
