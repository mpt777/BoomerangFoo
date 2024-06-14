extends Directive
class_name D_Avoid

var TOO_CLOSE := 100
var MOVE_AWAY := 10
var WEIGHT := 10

func decide(enemy : Enemy) -> int:
	if not enemy.n_avoidance.bodies:
		return 0
	return 100
	
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
