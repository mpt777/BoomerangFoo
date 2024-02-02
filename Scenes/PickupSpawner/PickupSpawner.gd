extends Node3D
class_name PickupSpawner

@export
var max_concurrent_pickups := 3

const MANA_PICKUP = preload("res://Scenes/Pickup/ManaPickup/ManaPickup.tscn")

func _on_spawn_timer_timeout():
	var current_pickups = get_tree().get_nodes_in_group("Pickup")
	if len(current_pickups) < max_concurrent_pickups:
		create_new_pickup()
		
func pick_random_position() -> Vector3:
	var map : RID = get_world_3d().get_navigation_map()
	return NavigationServer3D.map_get_random_point(map, 1, false)
	
func create_new_pickup():
	var position = pick_random_position()
	var pickup := MANA_PICKUP.instantiate()
	pickup.position = position
	add_child(pickup)
	
