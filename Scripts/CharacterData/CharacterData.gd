extends Resource
class_name CharacterData

var character_name : String
var max_health := 1
var color : Color = Color(randf(),randf(),randf(),1)


func instantiate_scene() -> Character:
	return 

func _init():
	self.max_health = GameState.settings.character_max_health
