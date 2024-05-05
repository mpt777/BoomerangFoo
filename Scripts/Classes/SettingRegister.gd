extends Node
class_name SettingRegister

var _settings = {}

func register(setting: Setting) -> void:
	_settings[setting.code] = setting
	
func setting(code : String) -> Setting:
	return _settings[code]
	
func get_value(code : String, default):
	var _setting : Setting = _settings.get(code, null)
	if _setting:
		return _setting.get_value()
	return default
		
