extends Node
class_name ControllerAction

var action_name : String
var input_event : InputEvent
var button_index : int

func to_json() -> Dictionary:
	return  {
		"action_name": action_name,
		"input_event": input_event,
		"button_index": button_index
	}
