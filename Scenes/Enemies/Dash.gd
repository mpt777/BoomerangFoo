extends State

@export
var movement : Movement
@export
var dash : Dash

func enter():
	if dash.can_dash:
		dash.start_dash()
		movement.dash()
	else:
		Transitioned.emit(self, "walk")
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	movement.move(Vector3(randf_range(-1,1), 0, randf_range(-1,1)).normalized())
		
func _on_dash_end_dash():
	movement.end_dash()
	Transitioned.emit(self, "walk")	
