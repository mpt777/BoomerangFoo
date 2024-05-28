extends State

@export var body : Character

func _ready() -> void:
	body.signals.register("Attack.Attack", attack)

func enter():
	#await get_tree().process_frame
	body.n_pointer.start()
	body.avatar().cast("PreCast")
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass
	
func attack(str: String):
	body.n_pointer.reset()
	
	body.avatar().cast("Cast")
	body.signals.emit_signal("Wand.Attack", str)
	
	Transitioned.emit(self, "idle")
