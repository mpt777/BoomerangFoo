extends Node3D

@onready var stage = $"."
@onready var character_spawner = $CharacterSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	character_spawner.spawn(GameState.players)


# Called every frame. 'delta' is the elapsed time since the previous frame.


