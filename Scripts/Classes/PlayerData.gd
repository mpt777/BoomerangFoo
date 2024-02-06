extends Node
class_name PlayerData

var player_name : String
var controller : Controller
var actions : Array


func default_controller():
	var c = Controller.new()
	c.register_action("move_up", InputEventKey.new(), KEY_W)
	c.register_action("move_down", InputEventKey.new(), KEY_S)
	c.register_action("move_left", InputEventKey.new(), KEY_A)
	c.register_action("move_right", InputEventKey.new(), KEY_D)
	c.register_action("thow_weapon", InputEventKey.new(), KEY_Q)
	c.register_action("dash", InputEventKey.new(), KEY_SPACE)
	c.register_action("attack_range", InputEventMouseButton.new(), MOUSE_BUTTON_LEFT)
	c.register_action("attack_melee", InputEventMouseButton.new(), MOUSE_BUTTON_RIGHT)
	return c

