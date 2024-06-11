extends Resource
class_name SettingRegister

var _settings = {}

func register(p_setting: Setting) -> void:
	self._settings[p_setting.code] = p_setting
	
func setting(code : String) -> Setting:
	return self._settings.get(code, null)
	
func get_value(code : String, default):
	var _setting : Setting = self._settings.get(code, null)
	if _setting:
		return _setting.get_value()
	return default
	
func settings() -> Dictionary:
	return self._settings

func reset(code: String) -> void:
	var _setting : Setting = self.setting(code)
	_setting.reset()

func reset_all() -> void:
	for attr in self._settings:
		self.reset(attr)
		
		
func save_to_disk(path: String) -> void:
	var data = {}
	for attr in self.settings():
		var setting : Setting = self.setting(attr)
		data[setting.code] = setting.get_value()
	Serializer.write_json(Serializer.user(path), data)
	
func load_from_disk(path : String) -> void:
	var data = Serializer.read_json(Serializer.user(path))
	for attr in data:
		var setting : Setting = self.setting(attr)
		if setting:
			setting.set_value(data[setting.code])
