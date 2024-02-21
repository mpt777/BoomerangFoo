extends Control

var CHARACTER_CIRCLE := preload("res://UI/Scenes/AddCharacter/CharacterCircle.tscn")
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer

func _ready():
	# Connect to the input event signal
	#var joypads = Input.get_connected_joypads()
	#for item in joypads:
		#add_player(item)
	GameState.players = []
	Input.connect("joy_connection_changed", _joy_connection_changed)

func _joy_connection_changed(id, connected):
	print(id, connected)
	if connected:
		add_player(id)
	else:
		remove_player(id)
	
func add_player(id : int) -> void:
	var character_circle = CHARACTER_CIRCLE.instantiate()
	h_box_container.add_child(character_circle)
	
	var player_data = PlayerData.new()
	player_data.controller = Controller.new()
	player_data.controller.device_number = id
	player_data.controller.controller_number = id
	player_data.controller.is_joypad = true
	player_data.controller = player_data.load_default_controller()

	GameState.players.append(player_data)
	
func remove_player(id : int) -> void:
	print("TODO")

func _on_button_button_up():
	GameState.settings.save_to_disk()
	SceneManager.switch_scene("game")
	#get_tree().change_scene_to_file("res://Scenes/Enviroment/World/World.tscn")
