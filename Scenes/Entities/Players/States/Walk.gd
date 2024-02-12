extends State

@export
var movement : Movement
@export
var body : Player

func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	movement.move(body.get_input_direction())
	
func _input(event):
	if event.is_action_pressed(body.controller.action("dash")):
		Transitioned.emit(self, "dash")
