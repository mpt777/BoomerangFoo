extends State

@export var body : CharacterBody3D = null
@export var movement : Movement
@export var dodge_area : DodgeArea

func enter():
	pass
	
func exit():
	pass
	
func update(delta : float):
	pass
		
func physics_update(_delta : float):
	if dodge_area.other_projectiles_in_area:
		Transitioned.emit(self, "Dash")
