extends State

@export
var body : CharacterBody3D = null

@export
var movement : Movement

@export
var mana_component : ManaComponent = null

func select_new_position() -> void:
	var pickup : Pickup = get_tree().get_first_node_in_group("Pickup")
	if not pickup:
		return
	body.n_nav.target_location = pickup.global_position

func enter():
	print("here")
	
func exit():
	pass
	
func update(delta : float):
	if body.velocity == Vector3.ZERO:
		select_new_position()
	if abs(body.global_position.distance_to(body.n_nav.target_location)) < 2:
		select_new_position()
		
	if mana_component.mana != 0:
		Transitioned.emit(self, "Idle")
	
func physics_update(_delta : float):
	if body.current_movement_state() != "dash":
		body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	movement.move(body.target_direction)
	
	if body.target_player:
		body.n_hand.target_position = body.target_player.global_position
		body.n_hand.attack()
