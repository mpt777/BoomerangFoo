extends Resource
class_name GameSettings


var debug := true

var use_keyboard=false
var settings_name := "Default Settings"
var settings_index := 1

var character_max_health := 1
var character_default_range := preload("res://Scenes/Things/Spells/ResourceSpell/Projectiles/BaseSpell.tres")
var character_default_melee = preload("res://Scenes/Things/Spells/ResourceSpell/Projectiles/RockWallProjectile.tres")

var background_color : Color = Color(0.14, 0.14, 0.14)
var points_per_round = 5


var attrs = [
	"settings_name",
	"character_max_health",
	"character_default_range",
	"character_default_melee",
]


func ready():
	save_to_disk()

func settings_path() -> String:
	return "settings_{0}.save".format([settings_index])
	
func save_to_disk():
	var data = {}
	for attr in attrs:
		data[attr] = get(attr)
	Serializer.write_json(Serializer.user(settings_path()), data)
	
func load_from_disk():
	var data = Serializer.read_json(Serializer.user(settings_path()))
	for key in data:
		if key in attrs:
			set(key, data[key])
			
