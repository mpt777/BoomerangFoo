extends Node
#class_name GameState

# List of Player Data Objects
var players := []
var controllers := {}
var events := []
var settings : GameSettings = GameSettings.new().constructor()

var played_stages : Array
var round_index := 0


func _ready():
	#if self.settings.use_keyboard:
	process_keyboard()
	$"/root/Signals".connect("add_event", add_event)
	$"/root/Signals".connect("start_round", start_round)
	
	#for controller_id in Input.get_connected_joypads():
		#add_controller(controller_id, true)
	
	Input.connect("joy_connection_changed", _joy_connection_changed)

func _joy_connection_changed(id, connected):
	if connected:
		add_controller(id)
	else:
		remove_controller(id)
	process_keyboard()
	if self.controllers:
		$"/root/Signals".emit_signal("controllers_changed", self.controllers[id], connected)
	
func process_keyboard():
	if Input.get_connected_joypads():
		self.settings.use_keyboard = false
		for attr in self.controllers:
			var _controller : Controller = self.controllers[attr]
			if _controller.is_joypad:
				remove_controller(attr)
				return
	else:
		self.settings.use_keyboard = true
		add_controller(0, false)
		return
	
	
func add_controller(id : int, is_joypad: bool = true) -> void:
	var controller := Controller.new().constructor(id, is_joypad)
	controllers[controller.get_controller_number()] = controller 
	if is_joypad:
		register_joypad(controller)
	else:
		register_keyboard(controller)
	
func remove_controller(id : int) -> void:
	controllers.erase(id)
	
func _input(event):
	for index in controllers:
		var controller : Controller = controllers[index]
		if not controller.is_joypad:
			continue
		if event.is_action_pressed(controller.action("ui_accept")):
			var ui = get_viewport().gui_get_focus_owner()
			if get_viewport().gui_get_focus_owner():
				ui.emit_signal("pressed")
				
func get_keyboard_controller() -> Controller:
	for index in self.controllers:
		var controller = self.controllers[index]
		if not controller.is_joypad:
			return controller
	return self.controllers[0]
		
func add_character(character_data : CharacterData) -> void:
	self.players.append(character_data)
	
func remove_character(character_data : CharacterData) -> void:
	var to_remove := -1
	for index in len(self.players):
		if self.players[index] == character_data:
			to_remove = index
			break
	if to_remove > -1:
		self.players.remove_at(to_remove)
		
func add_event(event : Event) -> void:
	event.round_index = round_index
	events.append(event)
	
func start_round() -> void:
	round_index += 1
	
	
func _physics_process(delta: float) -> void:
	$"/root/Signals".emit_signal("physics_process", delta)
	
	
	
	
	
	
func register_controller(controller=null) -> Controller:
	if not controller:
		controller = Controller.new()
	if controller.is_joypad:
		return register_joypad(controller)
	return register_keyboard(controller)

func register_keyboard(controller : Controller):
	ControllerAction.new().constructor("move_up", InputEventKey.new(), KEY_W).register(controller)
	ControllerAction.new().constructor("move_down", InputEventKey.new(), KEY_S).register(controller)
	ControllerAction.new().constructor("move_left", InputEventKey.new(), KEY_A).register(controller)
	ControllerAction.new().constructor("move_right", InputEventKey.new(), KEY_D).register(controller)
	ControllerAction.new().constructor("dash", InputEventKey.new(), KEY_SPACE).register(controller)
	ControllerAction.new().constructor("attack_range", InputEventMouseButton.new(), MOUSE_BUTTON_LEFT).register(controller)
	ControllerAction.new().constructor("attack_melee", InputEventMouseButton.new(), MOUSE_BUTTON_RIGHT).register(controller)
	
	ControllerAction.new().constructor("ui_up", InputEventKey.new(), KEY_UP).register(controller)
	ControllerAction.new().constructor("escape", InputEventKey.new(), KEY_ESCAPE).register(controller)
	ControllerAction.new().constructor("ui_down", InputEventKey.new(), KEY_DOWN).register(controller)
	ControllerAction.new().constructor("ui_left", InputEventKey.new(), KEY_LEFT).register(controller)
	ControllerAction.new().constructor("ui_right", InputEventKey.new(), KEY_RIGHT).register(controller)
	
	ControllerAction.new().constructor("ui_accept", InputEventMouseButton.new(), MOUSE_BUTTON_LEFT).register(controller)
	return controller
	
	
func register_joypad(controller : Controller):
	controller.is_joypad = true
	ControllerAction.new().constructor("move_up", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, -1, 0.1).register(controller)
	ControllerAction.new().constructor("move_down", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, 1, 0.1).register(controller)
	ControllerAction.new().constructor("move_left", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, -1, 0.1).register(controller)
	ControllerAction.new().constructor("move_right", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, 1, 0.1).register(controller)
	
	ControllerAction.new().constructor("ui_up", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, -1, 0.1).register(controller)
	ControllerAction.new().constructor("ui_down", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_Y, 1, 0.1).register(controller)
	ControllerAction.new().constructor("ui_left", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, -1, 0.1).register(controller)
	ControllerAction.new().constructor("ui_right", InputEventJoypadMotion.new(), JOY_AXIS_LEFT_X, 1, 0.1).register(controller)
	ControllerAction.new().constructor("ui_accept", InputEventJoypadButton.new(), JOY_BUTTON_B).register(controller)
	
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
