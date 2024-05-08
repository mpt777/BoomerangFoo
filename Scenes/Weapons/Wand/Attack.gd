extends State

signal Attacked

@export var weapon : Wand

func enter():
	weapon.attack()
	Transitioned.emit(self, "Reloading")
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

