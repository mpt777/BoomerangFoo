extends Node3D
class_name CharacterSpawner

enum MODE {Order, Random}
var PLAYER = preload("res://Scenes/Entities/Players/Player.tscn")

var spawn_index = 0

func spawn(characters : Array):
	for character in characters:
		spawn_character(character)
	
func spawn_character(character : PlayerData):
	var player = PLAYER.instantiate()
	player.constructor(character)
	owner.add_child(player)
	
	var i = 0
	for child in get_children():
		if i == spawn_index:
			player.global_position = child.global_position
			spawn_index += 1
		i += 1
	
