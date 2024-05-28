extends State
class_name AiBehaviorState

@export var body : Character = null
var can_attack := true

func _ready() -> void:
	body.signals.register("Wand.Reloaded", set_can_attack)
	#body.signals.register("Attack.Start", func(): Transitioned.emit(self, "attack"))
	
func get_target_player() -> Character:
	return Utils.closest_node_in_group(body.global_position, "Character")
	
func select_new_position() -> void:
	var method = 2
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
	
func set_new_position_if_arrived() -> void:
	if body.velocity == Vector3.ZERO:
		select_new_position()
	if abs(body.global_position.distance_to(body.n_nav.target_location)) < 6:
		select_new_position()
		
		
func update_target_direction() -> void:
	body.target_direction = (body.n_nav.get_next_path_position() - body.global_position).normalized()
	
	
func set_can_attack() -> void:
	self.can_attack = true
	
func attack() -> void:
	if not GameState.settings.settings.get_value("enemy_attack", true):
		return
	if not body.target_player:
		return
	if body.n_mana.mana <= 0:
		return
	if body.n_wand.n_state.current_state.is_alias("Reloading"):
		return
		
	body.signals.emit_signal("Attack.Start")
	
	await GameState.get_tree().create_timer(0.3).timeout
	body.signals.emit_signal("Attack.Attack", "range")
	can_attack = false
		

