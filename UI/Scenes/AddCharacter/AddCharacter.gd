extends Control

var CHARACTER_CIRCLE := preload("res://UI/Scenes/AddCharacter/CharacterCircle.tscn")
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer

func _ready():
	#GameState.players = []
	$"/root/Signals".connect("controllers_changed", modify_player)
	
	
func modify_player(id : int, connected : bool) -> void:
	if connected:
		add_player(id)
	else:
		remove_player()
	
func add_player(id : int) -> void:
	var player_data = PlayerData.new()
	player_data.controller = Controller.new()
	player_data.controller.device_number = id 
	player_data.controller.controller_number = id
	player_data.controller.is_joypad = true
	player_data.controller = player_data.load_default_controller()
	add_character(player_data)
	
func add_bot() -> void:
	var enemy_data = EnemyData.new()
	add_character(enemy_data)
	
func add_character(character_data : CharacterData) -> void:
	var character_circle = CHARACTER_CIRCLE.instantiate() as CharacterCircle
	h_box_container.add_child(character_circle)
	character_circle.set_color(character_data.color)
	GameState.players.append(character_data)

func remove_player():
	pass

func _on_button_button_up():
	GameState.settings.save_to_disk()
	SceneManager.switch_scene("game")
	#get_tree().change_scene_to_file("res://Scenes/Enviroment/World/World.tscn")
