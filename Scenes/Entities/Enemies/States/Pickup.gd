extends State

@export var body : CharacterBody3D = null
@export var movement : Movement
@export var mana_component : ManaComponent = null

var pickup_location := Vector3(-1,-1,-1)

func find_pickup_location():
	var pickup : Pickup = get_tree().get_first_node_in_group("Pickup")
	if pickup:
		pickup_location = body.ai.position_in_map(pickup.global_position)
	else:
		pickup_location = Vector3(-1,-1,-1)
		
func select_new_position() -> void:
	body.n_nav.target_location = body.ai.pick_point_around_player(12)
		

func enter():
	pass
	
func exit():
	pass
	
	
func update(_delta : float):
	self.find_pickup_location()
	
	if pickup_location != Vector3(-1,-1,-1):
		
		body.n_nav.target_location = pickup_location
	else:
		if body.velocity == Vector3.ZERO:
			select_new_position()
		if abs(body.global_position.distance_to(body.n_nav.target_location)) < 2:
			select_new_position()

	if mana_component.mana != 0:
		return
		Transitioned.emit(self, "Idle")
	
func physics_update(_delta : float):
	if body.current_movement_state() != "dash":
		body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	movement.move(body.target_direction)
	
	if body.target_player:
		body.n_hand.target_position = body.target_player.global_position
		body.n_hand.use("range")
