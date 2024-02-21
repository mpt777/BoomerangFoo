extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_debug_button_down():
	SceneManager.switch_scene("game")
	
func _on_start_pressed():
	SceneManager.switch_scene("add_character")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_credits_button_down():
	pass # Replace with function body.


func _on_quit_button_down():
	get_tree().quit() 



