extends Node
class_name GameSettings


var debug := true

var settings_name := "Default Settings"
var settings_index := 1
var character_max_health := 1

func ready():
	save_to_disk()

func settings_path() -> String:
	return "settings_{0}.save".format([settings_index])

func save_to_disk():
	var data := {
		"settings_name": settings_name,
		"character_max_health": character_max_health,
	}
	Serializer.write_json(Serializer.user(settings_path()), data)
	
func load_from_disk():
	var data = Serializer.read_json(Serializer.user(settings_path()))
	settings_name = data["settings_name"]
	character_max_health = data["character_max_health"]
