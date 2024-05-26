extends State

@export var movement : Movement
@export var body : Character

func _ready():
	body.signals.register("Movement.dash", func(): Transitioned.emit(self, "dash"))

func enter():
	pass
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	if (body.velocity.y > 0.05):
		body.avatar().travel("Idle")
	elif (body.velocity.length() > 0.05):
		body.avatar().travel("Walk")
	else:
		body.avatar().travel("Idle")
	#movement.move(body.get_input_direction())
	
#func _input(event):
	#if event.is_action_pressed(body.controller.action("dash")):
		#Transitioned.emit(self, "dash")
