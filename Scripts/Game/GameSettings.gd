@tool
extends Resource
class_name GameSettings


var debug := true

var use_keyboard=true
var settings_name := "Default Settings"
var settings_index := 1

var character_max_health := 1
var character_default_range := preload("res://Scenes/Things/Spells/ResourceSpell/Projectiles/BaseSpell.tres")
var character_default_melee = preload("res://Scenes/Things/Spells/ResourceSpell/Projectiles/RockWallProjectile.tres")

var background_color : Color = Color(0.14, 0.14, 0.14)
var points_per_round = 5

var settings := SettingRegister.new() 

func constructor() -> GameSettings:
	self.settings.register(
		Setting.new().constructor("Sound", "sound", 50, 
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), setting.get_value())
	))
	self.settings.register(
		Setting.new().constructor("SFX", "sfx", 50, 
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), setting.get_value())
	))
	self.settings.register(
		Setting.new().constructor("Music", "music", 50,
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), setting.get_value())
	))
	self.settings.register(
		Setting.new().constructor("Full Screen", "full_screen", false,
		func(setting : Setting): 
			var value = DisplayServer.WINDOW_MODE_WINDOWED
			if setting.value:
				value = DisplayServer.WINDOW_MODE_FULLSCREEN 
			DisplayServer.window_set_mode(value)
	))
	self.settings.register(
		Setting.new().constructor("Can Enemies Attack", "enemy_attack", true,
		func(_setting : Setting): 
			pass
	))
	return self

func settings_path() -> String:
	return "settings_{0}.save".format([settings_index])
	
func save_to_disk():
	var data = {}
	for attr in self.settings.settings():
		var setting : Setting = self.settings.setting(attr)
		data[setting.code] = setting.get_value()
	Serializer.write_json(Serializer.user(settings_path()), data)
	
func load_from_disk():
	var data = Serializer.read_json(Serializer.user(settings_path()))
	for attr in data:
		var setting : Setting = self.settings.setting(attr)
		if setting:
			setting.set_value(data[setting.code])
			
