extends Node3D

@onready var stage = $"."
@onready var character_spawner = $CharacterSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.players:
		character_spawner.spawn(GameState.players)
	else:
		character_spawner.spawn(GameStateDebug.default_character_data())


# Called every frame. 'delta' is the elapsed time since the previous frame.


