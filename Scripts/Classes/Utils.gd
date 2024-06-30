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
	if not item in array:
		return false
	var to_remove = find_item(array, item)
	if to_remove > -1:
		array.remove_at(to_remove)
		return true
	return false
	
func find_item(array, item) -> int:
	if not item in array:
		return -1
	for index in len(array):
		if array[index] == item:
			return index
	return -1
	
func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)

	return unique

