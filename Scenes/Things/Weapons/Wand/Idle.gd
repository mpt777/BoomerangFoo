extends State

func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
		
func physics_update(_delta : float):
	pass
	
func attack():
	Transitioned.emit(self, "Attack")
	
