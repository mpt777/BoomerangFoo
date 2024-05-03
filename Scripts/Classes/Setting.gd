extends Node
class_name Setting

var label : String
var code : String
var updated : Callable
var default
var value
var bound

func constructor():
	pass
	
func load_from_save():
	pass
	
func _update(value):
	self.value = value
	self.updated.call()
	
func bind(node : Control):
	self.bound = node
	
	if self.bound is HSlider:
		self.bound.value_changed.connect(self._update)
	elif self.bound is CheckButton:
		self.bound.toggled.connect(self._update)
		
