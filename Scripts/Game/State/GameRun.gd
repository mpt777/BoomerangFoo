extends Resource
class_name GameRun

@export var config : GameLoopData

var played_stages : Array
var round_index := 0
var events : Array[Event]

func constructor() -> GameRun:
	self.config = preload("res://Scenes/GameLoop/GameLoopData.tres")
	Game.get_tree().get_root().get_node("/root/Signals").connect("add_event", add_event)
	Game.get_tree().get_root().get_node("/root/Signals").connect("start_round", start_round)
	return self


func start_round():
	self.round_index += 1

# Events #######################################################################

func add_event(event : Event) -> void:
	event.round_index = self.round_index
	self.events.append(event)
