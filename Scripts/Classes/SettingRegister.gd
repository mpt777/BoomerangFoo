extends Node
class_name SettingRegister

var _settings = {}

func register(setting: Setting) -> void:
	self._settings[setting.code] = setting
	
func setting(code : String) -> Setting:
	return self._settings[code]
	
func get_value(code : String, default):
	var _setting : Setting = self._settings.get(code, null)
	if _setting:
		return _setting.get_value()
	return default
	
func settings() -> Dictionary:
	return self._settings
		
