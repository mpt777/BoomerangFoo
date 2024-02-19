extends Node
#class_name GameState

# List of Player Data Objects
var players := []
var events := []
var settings := GameSettings.new()

var played_stages : Array
var round_index := 0


func _ready():
	players = GameStateDebug.default_character_data()
	$"/root/Signals".connect("add_event", add_event)
	$"/root/Signals".connect("start_round", start_round)

func add_event(event : Event) -> void:
	event.round_index = round_index
	events.append(event)
	
func start_round() -> void:
	round_index += 1
