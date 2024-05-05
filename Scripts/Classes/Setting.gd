extends Node
class_name Setting

var label : String
var code : String
var updated : Callable
var default
var value

func constructor(label: String, code: String, default, updated: Callable) -> Setting:
	self.label = label
	self.code = code
	self.updated = updated
	self.default = default
	return self
	
func set_value(value):
	self.value = value
	self.updated.call(self)
	
func get_value():
	if self.value != null:
		return self.value
	return self.default
	
func _update(value):
	self.value = value
	self.updated.call(self)
