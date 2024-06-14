extends Directive
class_name D_Random

var WEIGHT := 20

func decide(enemy : Enemy) -> int:
	if enemy.global_position.distance_squared_to(enemy.n_nav.target_location) < 6:
		return 1
	return 0
	
func apply(enemy : Enemy) -> void:
	enemy.ai.set_new_position(enemy.ai_map.random_position())
	
	
