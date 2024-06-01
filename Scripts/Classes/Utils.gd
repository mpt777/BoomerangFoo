extends Node

func closest_node_in_group(origin: Vector3, group_name: String) -> Node3D:
	var nodes := get_tree().get_nodes_in_group(group_name)
	var nearest : float = INF
	var closest_player : Node3D = null
	for node in nodes:
		var distance := origin.distance_squared_to(node.global_position)
		if distance and distance < nearest:
			nearest = distance
			closest_player = node
	return closest_player
	
func remove_item(array, item) -> bool:
	var to_remove := -1
	for index in len(array):
		if array[index] == item:
			to_remove = index
			break
	if to_remove > -1:
		array.remove_at(to_remove)
		return true
	return false

