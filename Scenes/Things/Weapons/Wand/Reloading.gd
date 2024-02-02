extends State



func enter():
	$Timer.start()
	
func exit():
	pass
	
func update(delta : float):
	pass
		
func physics_update(_delta : float):
	pass

func _on_timer_timeout():
	Transitioned.emit(self, "Idle")
