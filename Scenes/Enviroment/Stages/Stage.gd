extends Node3D

@onready var stage = $"."
@onready var character_spawner = $CharacterSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.players:
		character_spawner.spawn(GameState.players)
	else:
		character_spawner.spawn(GameStateDebug.default_character_data())
		
	$"/root/Signals".connect("update_character", update_character)

func update_character() -> void:
	var characters := get_tree().get_nodes_in_group("Character").filter(func(x): return not x.is_queued_for_deletion())
	
	if len(characters) <= 1:
		end_round()
	
func end_round():
	SceneManager.switch_scene("game")
# Called every frame. 'delta' is the elapsed time since the previous frame.


