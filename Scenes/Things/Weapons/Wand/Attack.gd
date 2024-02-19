extends State

signal Attacked

@export
var weapon : Wand

func enter():
	weapon.current_spell.cast(weapon)
	Transitioned.emit(self, "Reloading")
	Attacked.emit()
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

