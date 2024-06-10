extends Resource
class_name Setting

var label : String
var code : String
var updated : Callable
var default
var value

signal Updated

func constructor(p_label: String, p_code: String, p_default, p_updated: Callable) -> Setting:
	self.label = p_label
	self.code = p_code
	self.updated = p_updated
	self.default = p_default
	return self
	
func get_value():
	if self.value != null:
		return self.value
	return self.default
	
func _update(p_value) -> void:
	self.value = p_value
	self.updated.call(self)
	self.Updated.emit(self.value)
	
func reset() -> void:
	if self.default != null:
		self._update(self.default)
		
func set_value(p_value) -> void:
	self._update(p_value)
