extends State

@export var movement : Movement
@export var body : Character


func enter():
	pass
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	movement.move(body.get_input_direction())
