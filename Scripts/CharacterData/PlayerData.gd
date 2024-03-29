extends CharacterData
class_name PlayerData

var controller : Controller
var actions : Array

#var PLAYER = preload("res://Scenes/Entities/Players/Player.tscn")

func instantiate_scene() -> Character:
	return load("res://Scenes/Entities/Players/Player.tscn").instantiate()

func default_controller():
	var c = Controller.new()
	ControllerAction.new().constructor("move_up", InputEventKey.new(), KEY_W).register(c)
	ControllerAction.new().constructor("move_down", InputEventKey.new(), KEY_S).register(c)
	ControllerAction.new().constructor("move_left", InputEventKey.new(), KEY_A).register(c)
	ControllerAction.new().constructor("move_right", InputEventKey.new(), KEY_D).register(c)
	ControllerAction.new().constructor("dash", InputEventKey.new(), KEY_SPACE).register(c)
	ControllerAction.new().constructor("attack_range", InputEventMouseButton.new(), MOUSE_BUTTON_LEFT).register(c)
	ControllerAction.new().constructor("attack_melee", InputEventMouseButton.new(), MOUSE_BUTTON_RIGHT).register(c)
	return c
	
func load_default_controller():
	controller.is_joypad = true
	ControllerAction.new().constructor("move_up", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, -1, 0.1).register(controller)
	ControllerAction.new().constructor("move_down", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, 1, 0.1).register(controller)
	ControllerAction.new().constructor("move_left", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, -1, 0.1).register(controller)
	ControllerAction.new().constructor("move_right", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, 1, 0.1).register(controller)
	
	ControllerAction.new().constructor("look_up", InputEventJoypadMotion.new(), JOY_AXIS_RIGHT_Y, -1, 0.1).register(controller)
	ControllerAction.new().constructor("look_down", InputEventJoypadMotion.new(), JOY_AXIS_RIGHT_Y, 1, 0.1).register(controller)
	ControllerAction.new().constructor("look_left", InputEventJoypadMotion.new(), JOY_AXIS_RIGHT_X, -1, 0.1).register(controller)
	ControllerAction.new().constructor("look_right", InputEventJoypadMotion.new(), JOY_AXIS_RIGHT_X, 1, 0.1).register(controller)
	
	ControllerAction.new().constructor("dash", InputEventJoypadButton.new(), JOY_BUTTON_LEFT_SHOULDER).register(controller)
	ControllerAction.new().constructor("dash", InputEventJoypadButton.new(), JOY_BUTTON_LEFT_STICK).register(controller)
	ControllerAction.new().constructor("dash", InputEventJoypadButton.new(), JOY_BUTTON_A).register(controller)
	#ControllerAction.new().constructor("dash", InputEventJoypadButton.new(), JOY_BUTTON_B).register(controller)
	
	
	ControllerAction.new().constructor("attack_range", InputEventJoypadButton.new(), JOY_BUTTON_Y).register(controller)
	#ControllerAction.new().constructor("attack_range", InputEventJoypadButton.new(), JOY_BUTTON_RIGHT_SHOULDER ).register(controller)
	ControllerAction.new().constructor("attack_range", InputEventJoypadMotion.new(), JOY_AXIS_TRIGGER_RIGHT ).register(controller)
	
	ControllerAction.new().constructor("attack_melee", InputEventJoypadButton.new(), JOY_BUTTON_X).register(controller)
	ControllerAction.new().constructor("attack_melee", InputEventJoypadButton.new(), JOY_BUTTON_B).register(controller)
	#ControllerAction.new().constructor("attack_melee", InputEventJoypadButton.new(), JOY_BUTTON_LEFT_SHOULDER ).register(controller)
	ControllerAction.new().constructor("attack_melee", InputEventJoypadButton.new(), JOY_BUTTON_RIGHT_SHOULDER ).register(controller)
	#ControllerAction.new().constructor("attack_melee", InputEventJoypadMotion.new(), JOY_AXIS_TRIGGER_LEFT  ).register(controller)
	return controller
