extends State

@export var body : Character

func _ready() -> void:
	body.signals.register("Attack.Start", func(): Transitioned.emit(self, "attack"))
	
func enter():
	pass
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass
