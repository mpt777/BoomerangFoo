extends Control

var CHARACTER_CIRCLE := preload("res://UI/Scenes/AddCharacter/CharacterCircle/CharacterCircle.tscn")
@onready var character_list = $MarginContainer/VBoxContainer/CharacterList

@onready var ready_container = $MarginContainer/VBoxContainer/AvatarSelect
@onready var bots_container = $MarginContainer/VBoxContainer/Bots
@onready var settings_container = $MarginContainer/VBoxContainer/GameSettings
@onready var start_container = $MarginContainer/VBoxContainer/StartGame
@onready var avatar_select = $MarginContainer/VBoxContainer/AvatarSelect/Container/AvatarSelect

var containers := []

func _ready():
	#GameState.players = []
	$MarginContainer/VBoxContainer/AvatarSelect/Ready.grab_focus()
	containers = [
		ready_container,
		bots_container,
		settings_container,
		start_container
	]

	$"/root/Signals".connect("controllers_changed", modify_player)
	add_player(0, false)
	for controller in GameState.controllers:
		add_player(GameState.controllers[controller].device_number)


func modify_player(id : int, connected : bool) -> void:
	if connected:
		add_player(id)
	else:
		remove_player(id)
	
func add_player(id : int, is_joypad: bool = true) -> void:
	var player_data = PlayerData.new()
	player_data.controller = Controller.new().constructor(id, is_joypad)
	player_data.register_controller()
	add_character(player_data)
	
	if player_data.controller.is_joypad:
		var avatar_select_circle : AvatarSelectCircle = avatar_select.random_avatar()
		avatar_select_circle.button.emit_signal("ControllerAdded", player_data.controller)
	
func remove_player(id: int) -> void:
	for child in character_list.get_children():
		if child.character_data.controller.device_number == id:
			GameState.remove_character(child.character_data)
			child.queue_free()
			return
	
func add_bot() -> void:
	var enemy_data = EnemyData.new()
	add_character(enemy_data)
	
func add_character(character_data : CharacterData) -> void:
	var character_circle = CHARACTER_CIRCLE.instantiate() as CharacterCircle
	character_circle.constructor(character_data)
	character_list.add_child(character_circle)
	GameState.add_character(character_data)

func remove_character(character_data : CharacterData):
	for child in character_list.get_children():
		child = child as CharacterCircle
		if child.character_data == character_data:
			child.queue_free()
			GameState.remove_character(character_data)

func hide_containers():
	for container in containers:
		container.visible = false
		
	$MarginContainer/VBoxContainer/Bots/AddBots.grab_focus()
		
### Bots ####################################################################
func _on_ready_pressed():
	hide_containers()
	bots_container.visible=true
	
func _on_remove_bot_pressed():
	var last_child_data = character_list.get_child(character_list.get_child_count() - 1) as CharacterCircle
	if last_child_data.character_data is EnemyData:
		remove_character(last_child_data.character_data)

func _on_add_bot_pressed():
	add_bot()

func _on_add_bots_pressed():
	SceneManager.switch_scene("game")
	
#####################################################################################
func _on_button_button_up():
	GameState.settings.save_to_disk()
	SceneManager.switch_scene("game")

