extends Node
#class_name GameState

# List of Player Data Objects
var players := []
var controllers := {}
var events := []
var settings := GameSettings.new()

var played_stages : Array
var round_index := 0


func _ready():
	players = GameStateDebug.default_character_data()
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
	controllers[id] = {}
	#var player_data = PlayerData.new()
	#player_data.controller = Controller.new()
	#player_data.controller.device_number = id 
	#player_data.controller.controller_number = id
	#player_data.controller.is_joypad = true
	#player_data.controller = player_data.load_default_controller()
#
	#players.append(player_data)
	
func remove_controller(id : int) -> void:
	controllers.erase(id)
	
func add_event(event : Event) -> void:
	event.round_index = round_index
	events.append(event)
	
func start_round() -> void:
	round_index += 1
