extends Node
#class_name GameState

# List of Player Data Objects
var players := []
var controllers := {}
var events := []
var settings := GameSettings.new()

var played_stages : Array
var round_index := 0

var controller := Controller.new()


func _ready():
	#players = GameStateDebug.default_character_data()
	
	initialize_controller()
	$"/root/Signals".connect("add_event", add_event)
	$"/root/Signals".connect("start_round", start_round)
	
	Input.connect("joy_connection_changed", _joy_connection_changed)

func _joy_connection_changed(id, connected):
	if connected:
		add_controller(id)
	else:
		remove_controller(id)
	$"/root/Signals".emit_signal("controllers_changed", id, connected)
	
func add_controller(id : int) -> void:
	controllers[id] = Controller.new()
	controllers[id].device_number = id 
	controllers[id].controller_number = id
	controllers[id].is_joypad = true
	
func remove_controller(id : int) -> void:
	controllers.erase(id)
	
func initialize_controller():
	controller.device_number = 0
	controller.controller_number = 0
	ControllerAction.new().constructor("ui_accept", InputEventJoypadButton.new(), JOY_BUTTON_B).register(controller)
	
func _input(event):
	if event.is_action_pressed(controller.action("ui_accept")):
		var ui = get_viewport().gui_get_focus_owner()
		if get_viewport().gui_get_focus_owner():
			ui.emit_signal("pressed")
		
		
		
func add_event(event : Event) -> void:
	event.round_index = round_index
	events.append(event)
	
func start_round() -> void:
	round_index += 1
