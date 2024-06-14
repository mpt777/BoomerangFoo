extends Directive
class_name D_NoStuck

var stuck_ticks := 10
var MAX_STUCK_TICKS = 1

var _old_position : Vector3

func moved(enemy : Enemy) -> float:
	return enemy.global_position.distance_squared_to(_old_position)
	
func decide(enemy : Enemy) -> int:
	var _weight := 0
	if stuck_ticks > MAX_STUCK_TICKS:
		_weight = 50
		
	if moved(enemy) <= 0.0:
		stuck_ticks += 1
	else:
		stuck_ticks = 0
		
	self._old_position = enemy.global_position

	return _weight
	
func apply(enemy : Enemy) -> void:
	enemy.ai.set_new_position(enemy.ai_map.random_position())


