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

