extends Directive
class_name D_AvoidPlayer

var TOO_CLOSE := 100
var MOVE_AWAY := 10
var WEIGHT := 10

func decide(enemy : Enemy) -> int:
	if not enemy.target_player:
		return 0
	var dist := enemy.global_position.distance_squared_to(enemy.target_player.global_position)
	if dist > TOO_CLOSE:
		return 0
	return WEIGHT
	
func apply(enemy : Enemy) -> void:
	var direction = enemy.global_position.direction_to(enemy.target_player.global_position)
	var pos = enemy.ai_map.position_in_map(enemy.global_position - (direction * MOVE_AWAY))
	enemy.ai.set_new_position(pos)
	

