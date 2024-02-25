extends State

@export
var movement : Movement
@export
var body : Character

func _ready():
	body.signals.register("Movement.dash", func(): Transitioned.emit(self, "dash"))

func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass
	#movement.move(body.get_input_direction())
	
#func _input(event):
	#if event.is_action_pressed(body.controller.action("dash")):
		#Transitioned.emit(self, "dash")
