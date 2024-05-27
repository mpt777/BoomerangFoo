extends State

@export var movement : Movement
@export var body : Character


func enter():
	body.n_pointer.start()
	body.avatar().cast("PreCast")
		
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	movement.move(body.get_input_direction())

	#if event.is_action_pressed(controller.action("attack_range")) or event.is_action_pressed(controller.action("attack_melee")):
		#n_pointer.start()
		#avatar().travel("PreCast")
	#if event.is_action_released(controller.action("attack_range")):
		#signals.emit_signal("Wand.Attack", "range")
		#n_pointer.reset()
		#avatar().travel("Cast")
	#if event.is_action_released(controller.action("attack_melee")):
		#signals.emit_signal("Wand.Attack", "melee")
		#n_pointer.reset()
		#avatar().travel("Cast")
