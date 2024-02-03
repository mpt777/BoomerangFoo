extends State

signal Attacked

@export
var weapon : Wand

func enter():
	weapon.range_spell.cast(weapon)
	Transitioned.emit(self, "Reloading")
	Attacked.emit()
	
func exit():
	pass
	
func update(delta : float):
	pass
	
func physics_update(_delta : float):
	pass

