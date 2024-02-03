extends State

@export
var body : Node3D

func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	pass
		
func physics_update(_delta : float):
	pass
	
func attack():
	Transitioned.emit(self, "Attack")
	
