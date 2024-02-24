extends Control

var CHARACTER_CIRCLE := preload("res://UI/Scenes/AddCharacter/CharacterCircle.tscn")
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer

@onready var ready_container = $MarginContainer/VBoxContainer/Ready
@onready var bots_container = $MarginContainer/VBoxContainer/Bots
@onready var settings_container = $MarginContainer/VBoxContainer/GameSettings
@onready var start_container = $MarginContainer/VBoxContainer/StartGame

var containers := []

func _ready():
	#GameState.players = []
	$MarginContainer/VBoxContainer/Ready/Ready.grab_focus()
	containers = [
		ready_container,
		bots_container,
		settings_container,
		start_container
	]

	$"/root/Signals".connect("controllers_changed", modify_player)
	for controller in GameState.controllers:
		add_player(GameState.controllers[controller].device_number)
	
	
func modify_player(id : int, connected : bool) -> void:
	if connected:
		add_player(id)
	#else:
		#remove_player()
	
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
	character_circle.constructor(character_data)
	h_box_container.add_child(character_circle)
	GameState.players.append(character_data)

func remove_character(character_data):
	for child in h_box_container.get_children():
		child = child as CharacterCircle
		if child.character_data == character_data:
			child.queue_free()

func _on_button_button_up():
	GameState.settings.save_to_disk()
	SceneManager.switch_scene("game")
	#get_tree().change_scene_to_file("res://Scenes/Enviroment/World/World.tscn")


func hide_containers():
	for container in containers:
		container.visible = false
		
	$MarginContainer/VBoxContainer/Bots/AddBots.grab_focus()
		
### Bots ####################################################################
func _on_ready_pressed():
	hide_containers()
	bots_container.visible=true
	
func _on_remove_bot_pressed():
	var last_child_data = h_box_container.get_child(h_box_container.get_child_count() - 1) as CharacterCircle
	if last_child_data.character_data is EnemyData:
		remove_character(last_child_data.character_data)

func _on_add_bot_pressed():
	add_bot()

func _on_add_bots_pressed():
	SceneManager.switch_scene("game")
