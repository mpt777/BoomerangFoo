extends Node3D
class_name Stage

@onready var stage = $"."
@onready var character_spawner = $Functional/CharacterSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.players:
		character_spawner.spawn(Game.players)
		
