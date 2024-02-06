extends Control

var CHARACTER_CIRCLE := preload("res://UI/AddCharacter/CharacterCircle.tscn")
@onready var h_box_container = $MarginContainer/VBoxContainer/HBoxContainer

func _ready():
	# Connect to the input event signal
	#var joypads = Input.get_connected_joypads()
	#for item in joypads:
		#add_player(item)
	Input.connect("joy_connection_changed", _joy_connection_changed)

func _joy_connection_changed(id, connected):
	print(id, connected)
	add_player(id)
	
func add_player(id : int) -> void:
	var character_circle = CHARACTER_CIRCLE.instantiate()
	h_box_container.add_child(character_circle)

func _on_button_button_up():
	SceneManager.switch_scene("game")
	#get_tree().change_scene_to_file("res://Scenes/Enviroment/World/World.tscn")
