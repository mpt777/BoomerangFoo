extends State

@export var movement : Movement
@export var body : Character


func enter():
	(func(): body.avatar().walk_idle(1)).call_deferred()

func exit():
	pass

func update(_delta : float):
	pass

func physics_update(_delta : float):
	var input_direction : Vector3 = body.get_input_direction()
	
	movement.move(input_direction)
	if input_direction.length() > 0.05:
		Transitioned.emit(self, "walk")
