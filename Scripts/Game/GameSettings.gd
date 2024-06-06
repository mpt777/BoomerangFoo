@tool
extends Resource
class_name GameSettings


var debug := true

var use_keyboard=true
var settings_name := "Default Settings"
var settings_index := 1

var character_max_health := 1
var character_default_range := load("res://Scenes/Spells/ResourceSpell/Projectiles/BaseProjectile.tres")
var character_default_melee = load("res://Scenes/Spells/ResourceSpell/Projectiles/RockWallProjectile.tres")

var background_color : Color = Color(0.14, 0.14, 0.14)
var points_per_round = 5

var settings := SettingRegister.new() 

func constructor() -> GameSettings:
	self.settings.register(
		Setting.new().constructor("Sound", "sound", db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))), 
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(setting.get_value()))
	))
	self.settings.register(
		Setting.new().constructor("SFX", "sfx", db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))), 
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(setting.get_value()))
	))
	self.settings.register(
		Setting.new().constructor("Music", "music", db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))),
		func(setting : Setting): 
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(setting.get_value()))
	))
	self.settings.register(
		Setting.new().constructor("Full Screen", "full_screen", false,
		func(setting : Setting): 
			var value = DisplayServer.WINDOW_MODE_WINDOWED
			if setting.value:
				value = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
			DisplayServer.window_set_mode(value)
	))
	self.settings.register(
		Setting.new().constructor("VSYNC", "vsync", false,
		func(setting : Setting): 
			var value = DisplayServer.VSYNC_DISABLED
			if setting.value:
				value = DisplayServer.VSYNC_ENABLED  
			DisplayServer.window_set_vsync_mode(value)
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
	self.settings.save_to_disk(self.settings_path())
	
func load_from_disk():
	self.settings.load_from_disk(self.settings_path())
	
