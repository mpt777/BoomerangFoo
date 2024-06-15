extends Directive
class_name D_Avoid

var TOO_CLOSE := 100
var MOVE_AWAY := 10
var WEIGHT := 10

var stuck_ticks := 10
var MAX_STUCK_TICKS = 0
var _old_position : Vector3

func moved(enemy : Enemy) -> float:
	return enemy.global_position.distance_squared_to(_old_position)
	
func decide(enemy : Enemy) -> int:
	return 0
	if not enemy.n_avoidance.bodies:
		return 0
		
	var _weight := 0
	if stuck_ticks > MAX_STUCK_TICKS:
		_weight = 90
		
	if moved(enemy) <= 0.0:
		stuck_ticks += 1
	else:
		stuck_ticks = 0
		
	self._old_position = enemy.global_position

	return _weight
	
func apply(enemy : Enemy) -> void:
	if not enemy.n_avoidance.bodies:
		return
	var first = enemy.n_avoidance.bodies[0]
	
	var space = enemy.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = enemy.global_position
	ray_query.to = first.global_position
	ray_query.collide_with_areas = false
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		var pos = enemy.ai_map.position_in_map((enemy.global_position - raycast_result.position) - (raycast_result.normal * MOVE_AWAY))
		enemy.ai.set_new_position(pos)
		
func apply_old(enemy : Enemy) -> void:
	if not enemy.n_avoidance.bodies:
		return
	var first = enemy.n_avoidance.bodies[0]
	
	var space = enemy.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = enemy.global_position
	ray_query.to = first.global_position
	ray_query.collide_with_areas = false
	var raycast_result = space.intersect_ray(ray_query)
	if !raycast_result.is_empty():
		var pos = enemy.ai_map.position_in_map((enemy.global_position - raycast_result.position) - (raycast_result.normal * MOVE_AWAY))
		enemy.ai.set_new_position(pos)
