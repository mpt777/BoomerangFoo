extends Button
class_name MultiLayerButton

var controllers := []

signal ControllerAdded
signal ControllerRemoved

func add_controller(controller : Controller) -> void:
	controller.current_button = self
	self.controllers.append(controller)
	
func remove_controller(controller : Controller) -> void:
	var to_remove := -1
	for index in len(self.controllers):
		if self.controllers[index] == controller:
			to_remove = index
			break
	if to_remove > -1:
		self.controllers.remove_at(to_remove)
		ControllerRemoved.emit(controller)
	
func set_color(color: Color) -> void:
	get_material().set_shader_parameter("color", color)

func render_state():
	var color : Color = get_material().get_shader_parameter("color")
	if not self.controllers:
		color.a = 0
	else:
		color.a = 1
	set_color(color)
	
		
func _input(event):
	if not GameState.controllers[0].current_button:
		GameState.controllers[0].current_button = self
		set_color(Color.WEB_GREEN)
	if GameState.controllers[0].current_button != self:
		return
	if event.is_action_pressed(GameState.controllers[0].action("ui_accept")):
		print(event)
	if event.is_action_pressed(GameState.controllers[0].action("ui_left")):
		move_focus(SIDE_LEFT)
	if event.is_action_pressed(GameState.controllers[0].action("ui_right")):
		move_focus(SIDE_RIGHT)
	if event.is_action_pressed(GameState.controllers[0].action("ui_up")):
		move_focus(SIDE_TOP)
	if event.is_action_pressed(GameState.controllers[0].action("ui_down")):
		move_focus(SIDE_BOTTOM)
		
func move_focus(side : int):
	var node = find_valid_focus_neighbor(side)
	if not node:
		return
	print(self, node)
	node.emit_signal("ControllerAdded", GameState.controllers[0])
	emit_signal("ControllerRemoved", GameState.controllers[0])


func _on_controller_added(controller : Controller):
	self.add_controller(controller)
	self.render_state()


func _on_controller_removed(controller : Controller):
	self.remove_controller(controller)
	self.render_state()
	

		
