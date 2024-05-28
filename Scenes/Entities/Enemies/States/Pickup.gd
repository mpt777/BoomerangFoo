extends AiBehaviorState

@export var movement : Movement
@export var mana_component : ManaComponent = null

var pickup_location := Vector3(-1,-1,-1)

func set_pickup_location():
	var pickup : Pickup = get_tree().get_first_node_in_group("Pickup")
	if pickup:
		pickup_location = body.ai.position_in_map(pickup.global_position)
	else:
		pickup_location = Vector3(-1,-1,-1)

func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	self.set_pickup_location()
	
	if pickup_location != Vector3(-1,-1,-1):
		body.n_nav.target_location = pickup_location
	else:
		self.set_new_position_if_arrived()

	if mana_component.mana != 0:
		Transitioned.emit(self, "attack")
		
	self.update_target_direction()
	self.attack()
