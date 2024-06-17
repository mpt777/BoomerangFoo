extends Directive
class_name D_RangeAttack

var MIN_ATTACK_RANGE := 5
var MAX_ATTACK_RANGE := 1000
var ATTACK_CHANCE := 0.5
var velocities : Array[Vector3]

func ready() -> void:
	self.enemy.get_tree().get_root().get_node("/root/Signals").connect("physics_process", _physics_process)

func decide(enemy : Enemy) -> int:
	if not GameState.settings.settings.get_value("enemy_attack", true):
		return 0
	if not enemy.target_player:
		return 0
	if enemy.n_mana.mana <= 0:
		return 0
	if enemy.n_wand.n_state.current_state.is_alias("Reloading"):
		return 0
	if randf() < ATTACK_CHANCE:
		return 0
	var dist := enemy.global_position.distance_squared_to(enemy.target_player.global_position)
	if dist < MIN_ATTACK_RANGE or dist > MAX_ATTACK_RANGE:
		return 0
	if not self.ray_query(enemy):
		return 0
	return 50
	
func ray_query(enemy : Enemy) -> bool:
	var space = enemy.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = enemy.global_position
	ray_query.from.y = 0.5
	ray_query.to = enemy.target_player.global_position
	ray_query.to.y = 0.5
	ray_query.collide_with_areas = false
	ray_query.set_collision_mask(1 << 1 - 1)
	ray_query.exclude = [enemy]
	var raycast_result = space.intersect_ray(ray_query)
	if raycast_result.is_empty():
		return true
	var x = raycast_result.collider
	return false
	
	
func apply(enemy : Enemy) -> void:
	var total : Vector3 = self.velocities.reduce(func(i, accum): return accum + i)
	#print( self.enemy.target_player.velocity.length())
	if self.enemy.target_player.velocity.length() > 20:
		enemy.ai.aim_type = AimType.new().constructor(1, 0.1)
		print("sprint")
	elif total.length() > 50:
		enemy.ai.aim_type = AimType.new().constructor(0, 0.1)
		print("lead")
	else:
		enemy.ai.aim_type = AimType.new().constructor(1, 0.1)
		print("straight")
	
	enemy.signals.emit_signal("Attack.Start")
	enemy.signals.emit_signal("Attack.Attack", "range")


func _physics_process(delta : float) -> void:
	if not self.enemy.target_player:
		return
	self.velocities.append(self.enemy.target_player.velocity)
	while(len(self.velocities)) > 10:
		self.velocities.remove_at(0)
