extends CharacterData
class_name EnemyData

#var BOT = preload("res://Scenes/Entities/Enemies/Enemy.tscn")
var witch  = preload("res://Scenes/Entities/Avatar/Witch/witch_data.tres")


func _init():
	super._init()
	self.avatar = witch

func instantiate_scene() -> Character:
	return load("res://Scenes/Entities/Enemies/Enemy.tscn").instantiate()
