extends Node3D

class_name Controller

@export
var controller_number := 0

@export
var device_number := 0

#List of controller actions
var actions := {}
var is_joypad = false
	
# Description, public API to expose namespaced action
func action(action_name : String) -> String:
	return "{0}__{1}".format([controller_number, action_name])
	
# Description: Initialize internal dictionary of actions.. Should never be needed
#func initialize_actions() -> void:
	#for action in actions:
		#register_controller_action(actions[action])
		#
## Description: Initialize an array of existing actions
#func register_controller_actions(actions : Array) -> void:
	#for action in actions:
		#register_controller_action(action)
	
# Description: Wrapper method to create and initialize a controller action EZ
#func register_action(action_name : String, input_event : InputEvent, button_index : int, axis_value : int = 0, deadzone : float = 0) -> void:
	#var controller_action := ControllerAction.new()
	#controller_action.action_name = action_name
	#controller_action.input_event = input_event
	#controller_action.button_index = button_index
	#controller_action.axis_value = axis_value
	#controller_action.deadzone = deadzone
	#register_controller_action(controller_action)
	
#func register_controller_action(controller_action : ControllerAction) -> void:
	#controller_action.register_action(self, action(controller_action.action_name))
		
#func register_controller_action(controller_action : ControllerAction) -> void:
	#var action := action(controller_action.action_name)
	#var input_event := controller_action.input_event
	#var button_index := controller_action.button_index
	#var axis_value := controller_action.axis_value
	#var deadzone := controller_action.deadzone
	#
	#self.actions[action] = action
	#if InputMap.has_action(action):
		#InputMap.erase_action(action)
	#InputMap.add_action(action)
#
	#controller_action.input_event.device = device_number
	#
	#if input_event is InputEventKey:
		#input_event.keycode = button_index
	#elif input_event is InputEventJoypadButton:
		#input_event.button_index = button_index
	#elif input_event is InputEventMouseButton:
		#input_event.button_index = button_index
	#elif input_event is InputEventJoypadMotion:
		#input_event.axis = button_index
		#input_event.axis_value = axis_value
	#
	#InputMap.action_add_event(action, input_event)
	#
	#if input_event is InputEventJoypadMotion:
		#InputMap.action_set_deadzone(action, deadzone)
