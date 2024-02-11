extends CharacterData
class_name EnemyData

#var BOT = preload("res://Scenes/Entities/Enemies/Enemy.tscn")

func instantiate_scene() -> Character:
	return load("res://Scenes/Entities/Enemies/Enemy.tscn").instantiate()
