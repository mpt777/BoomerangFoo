extends Node
class_name ControllerAction

var action_name : String
var input_event : InputEvent
var button_index : int
var axis_value : int
var deadzone : float

func constructor(action_name : String, input_event : InputEvent, button_index : int, axis_value : int = 0, deadzone : float = 0) -> ControllerAction:
	self.action_name = action_name
	self.input_event = input_event
	self.button_index = button_index
	self.axis_value = axis_value
	self.deadzone = deadzone
	return self
	
func register(controller) -> void:
	var action : String = controller.action(action_name)
	#if InputMap.has_action(action):
		#InputMap.erase_action(action)
	if action == "64__ui_accept":
		print(action)
	if not InputMap.has_action(action):
		InputMap.add_action(action)
		print("added")
	else:
		print("BAD")

	input_event.device = controller.device_number
	
	if input_event is InputEventKey:
		input_event.keycode = button_index
	elif input_event is InputEventJoypadButton:
		input_event.button_index = button_index
	elif input_event is InputEventMouseButton:
		input_event.button_index = button_index
	elif input_event is InputEventJoypadMotion:
		input_event.axis = button_index
		input_event.axis_value = axis_value
	
	InputMap.action_add_event(action, input_event)
	
	if input_event is InputEventJoypadMotion:
		InputMap.action_set_deadzone(action, deadzone)

func to_json() -> Dictionary:
	return  {
		"action_name": action_name,
		"input_event": input_event,
		"button_index": button_index,
		"axis_value": axis_value,
		"deadzone": deadzone,
	}
