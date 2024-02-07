extends Node3D
class_name CharacterSpawner

enum MODE {Order, Random}
var PLAYER = preload("res://Scenes/Entities/Players/Player.tscn")

func spawn(characters : Array):
	var index = 0
	for character in characters:
		spawn_character(character, get_child(index))
		index += 1
		
	$"/root/Signals".emit_signal("refresh_follow_camera")
	
func spawn_character(character : PlayerData, node : Node):
	var player = PLAYER.instantiate()
	player.constructor(character)
	owner.add_child(player)
	
	player.global_position = node.global_position
	
