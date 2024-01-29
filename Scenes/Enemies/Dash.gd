extends State

@export
var movement : Movement
@export
var dash : Dash
@export
var body : CharacterBody3D = null

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
	pass
		
func _on_dash_end_dash():
	movement.end_dash()
	Transitioned.emit(self, "walk")
