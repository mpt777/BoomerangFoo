extends Control

var controller := Controller.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Debug.grab_focus()

func _on_debug_pressed():
	GameState.players = GameStateDebug.default_character_data()
	SceneManager.switch_scene("game")
	
func _on_start_pressed():
	SceneManager.switch_scene("add_character")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_credits_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit() 
