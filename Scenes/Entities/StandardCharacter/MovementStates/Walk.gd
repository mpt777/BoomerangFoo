extends State

@export var movement : Movement
@export var body : Character

func _ready():
	body.signals.register("Movement.dash", func(): Transitioned.emit(self, "dash"))

func enter():
	(func(): body.avatar().walk_idle(0)).call_deferred()
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	var input_direction : Vector3 = body.get_input_direction()
	if input_direction.length() < 0.05:
		Transitioned.emit(self, "idle")
	movement.move(input_direction)
