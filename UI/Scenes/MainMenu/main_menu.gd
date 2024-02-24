extends Control

var controller := Controller.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Debug.grab_focus()
	initialize_controller()
	
func initialize_controller():
	controller.device_number = 0
	controller.controller_number = 0
	ControllerAction.new().constructor("ui_accept", InputEventJoypadButton.new(), JOY_BUTTON_B).register(controller)
	
		
func _input(event):
	if event.is_action_pressed(controller.action("ui_accept")):
		print(get_viewport().gui_get_focus_owner().emit_signal("pressed"))
	
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



