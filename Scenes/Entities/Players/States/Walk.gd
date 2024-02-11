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
	if not body.can_move:
		return
	movement.move(body.get_input_direction())
	
func _input(event):
	if not body.can_move:
		return
	if event.is_action_pressed(body.controller.action("dash")):
		Transitioned.emit(self, "dash")
