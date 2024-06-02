extends CharacterData
class_name PlayerData

var controller : Controller
var actions : Array

func instantiate_scene() -> Character:
	return load("res://Scenes/Entities/Players/Player.tscn").instantiate()
