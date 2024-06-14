extends AiBehaviorState

@export var mana_component : ManaComponent = null
@export var movement : Movement


func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
		
func physics_update(_delta : float):
	if self.body.on_tick:
		self.tick()
	#self.update_target_direction()
	
func tick():
	self.attack()

