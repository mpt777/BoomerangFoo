extends State

@export var body : Character = null
@export var mana_component : ManaComponent = null
@export var movement : Movement



func enter():
	pass
	
func exit():
	pass
	
	
func select_new_position() -> void:
	var method := randi_range(0,2)
	var position := Vector3.ZERO 
	if method == 0:
		position = body.ai.pick_random_position()
	if method == 1:
		position = body.ai.pick_point_around_player(6)
	if method == 2:
		position = body.ai.pick_point_around_player(10)
		
	set_new_position(position)
	
func set_new_position(desired_position: Vector3) -> void:
	body.n_nav.target_location = desired_position
	
func update(_delta : float):
	if body.velocity == Vector3.ZERO:
		select_new_position()
	if abs(body.global_position.distance_to(body.n_nav.target_location)) < 2:
		select_new_position()
		
	if mana_component.mana == 0 and get_tree().get_first_node_in_group("Pickup"):
		Transitioned.emit(self, "Pickup")
		
func physics_update(_delta : float):
	if body.current_movement_state() != "dash":
		body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	movement.move(body.target_direction)
	
	return 
	if body.target_player:
		body.n_hand.target_position = body.target_player.global_position
		body.n_hand.use("range")

func _on_navigation_agent_3d_target_reached():
	select_new_position()
