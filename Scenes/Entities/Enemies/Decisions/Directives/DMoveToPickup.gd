extends Directive
class_name D_MoveToPickup

func decide(enemy : Enemy) -> int:
	var pickup : Pickup = enemy.get_tree().get_first_node_in_group("Pickup")
	if not pickup:
		return 0
	if enemy.n_mana.mana == 1:
		return 5
	if enemy.n_mana.mana == 0:
		return 20
	return 0
	
func apply(enemy : Enemy) -> void:
	var pickup : Pickup = enemy.get_tree().get_first_node_in_group("Pickup")
	if pickup:
		enemy.ai.set_new_position(enemy.ai_map.position_in_map(pickup.global_position))
	
	
