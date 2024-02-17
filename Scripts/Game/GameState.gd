extends Node
#class_name GameState

# List of Player Data Objects
var players := []
var settings := GameSettings.new()


func _ready():
	players = GameStateDebug.default_character_data()
	


