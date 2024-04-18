extends Control
class_name EtContainer

signal entered
signal exited

func enter() -> void:
	self.visible = true
	self.find_and_grab_focus()
	
func exit() -> void:
	self.visible = false
	
func find_and_grab_focus() -> void:
	var control := find_next_valid_focus()
	if control:
		return control.grab_focus()
