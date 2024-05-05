@tool
extends HBoxContainer
class_name SettingControl

@onready var n_label = $Label
var n_input
var setting : Setting

func set_text(text : String) -> void:
	n_label.text = text
	
func mount(setting : Setting) -> void:
	self.setting = setting
	
	set_text(self.setting.label)
	
	for child in self.get_children():
		if child is HSlider or child is CheckButton:
			self.n_input = child
			break
	
	if self.n_input is HSlider:
		self.n_input.value_changed.connect(self.setting._update)
		self.n_input.set_value_no_signal(self.setting.get_value())
	elif self.n_input is CheckButton:
		self.n_input.toggled.connect(self.setting._update)
		self.n_input.set_pressed_no_signal(self.setting.get_value())
