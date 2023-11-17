extends Node

class_name Controller

@export
var controller_number := 0

@export
var device_number := 0
	
func action(action_name : String) -> String:
	return "{0}__{1}".format([controller_number, action_name])
	
func register_action(action_name : String, input_event : InputEvent, button_index : int) -> void:
	var action = action(action_name)
	
#	if not InputMap.has_action(action):
	InputMap.add_action(action)
#		InputMap.erase_action(action_name)

	input_event.device = device_number
	
	if input_event is InputEventKey:
		input_event.keycode = button_index
	elif input_event is InputEventJoypadButton:
		input_event.button_index = button_index
	
	InputMap.action_add_event(action, input_event)
