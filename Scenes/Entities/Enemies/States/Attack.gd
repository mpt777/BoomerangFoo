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
	self.set_new_position_if_arrived()
		
	if mana_component.mana == 0 and get_tree().get_first_node_in_group("Pickup"):
		Transitioned.emit(self, "pickup")
	
	self.update_target_direction()
	self.attack()

