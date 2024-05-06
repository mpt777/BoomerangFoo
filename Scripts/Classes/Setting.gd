extends Node
class_name Setting

var label : String
var code : String
var updated : Callable
var default
var value

signal Updated

func constructor(label: String, code: String, default, updated: Callable) -> Setting:
	self.label = label
	self.code = code
	self.updated = updated
	self.default = default
	return self
	
func get_value():
	if self.value != null:
		return self.value
	return self.default
	
func _update(value) -> void:
	self.value = value
	self.updated.call(self)
	self.Updated.emit(self.value)
	
func reset() -> void:
	if self.default != null:
		self._update(self.default)
		
func set_value(value) -> void:
	self._update(value)
