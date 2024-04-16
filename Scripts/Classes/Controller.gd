extends Node3D

class_name Controller

@export var controller_number := 0
@export var device_number := 0

#List of controller actions
var actions := {}
var is_joypad = false
var current_button : MultiLayerButton
	

func constructor(id: int, is_joypad: bool = false) -> Controller:
	self.device_number = id
	self.controller_number = id
	self.is_joypad = is_joypad
	return self

# Description, public API to expose namespaced action
func action(action_name : String) -> String:
	return "{0}__{1}".format([self.get_controller_number(), action_name])
	
#used to allow for controllers and keyboards to share device indexes
func get_controller_number() -> int:
	if self.is_joypad:
		return self.controller_number
	return self.controller_number + 64

func grab_focus(button : MultiLayerButton) -> void:
	self.current_button = button
