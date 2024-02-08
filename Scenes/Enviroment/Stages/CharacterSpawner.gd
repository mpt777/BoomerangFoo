extends Node3D
class_name CharacterSpawner

enum MODE {Order, Random}

func spawn(characters : Array):
	var index = 0
	for character in characters:
		spawn_character(character, get_child(index))
		index += 1
		
	$"/root/Signals".emit_signal("refresh_follow_camera")
	
func spawn_character(character_data : CharacterData, node : Node):
	var character_scene = character_data.instantiate_scene()
	character_scene.constructor(character_data)
	owner.add_child(character_scene)
	
	character_scene.global_position = node.global_position
	
