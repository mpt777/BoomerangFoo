extends Button
class_name MultiLayerButton

@onready var n_margin : MarginContainer = $MarginContainer
@onready var n_border : ColorRect = $MarginContainer/Border

var controllers := []

signal ControllerAdded
signal ControllerRemoved
signal ControllerPressed

func _ready():
	self.set_border_width(-5)

func add_controller(controller : Controller) -> void:
	controller.current_button = self
	self.controllers.append(controller)
	print(self.text, self.controllers)
	
func remove_controller(controller : Controller) -> void:
	var to_remove := -1
	for index in len(self.controllers):
		if self.controllers[index] == controller:
			to_remove = index
			break
	if to_remove > -1:
		self.controllers.remove_at(to_remove)
		ControllerRemoved.emit(controller)
	
func set_border_width(width: int) -> void:
	n_margin.add_theme_constant_override("margin_top", width)
	n_margin.add_theme_constant_override("margin_left", width)
	n_margin.add_theme_constant_override("margin_bottom", width)
	n_margin.add_theme_constant_override("margin_right", width)
	
func set_color(color: Color) -> void:
	n_border.color = color

func render_state():
	var color : Color = n_border.color
	if not self.controllers:
		color.a = 0
	else:
		color.a = 1
	set_color(color)
	
		
func _input(event):
	for controller in self.controllers:
		process_input(event, controller)
			
			
func process_input(event : InputEvent, controller: Controller):
	if event.is_action_pressed(controller.action("ui_accept")):
		emit_signal("ControllerPressed", controller)
	if event.is_action_pressed(controller.action("ui_left")):
		move_focus(SIDE_LEFT, controller)
	if event.is_action_pressed(controller.action("ui_right")):
		move_focus(SIDE_RIGHT, controller)
	if event.is_action_pressed(controller.action("ui_up")):
		move_focus(SIDE_TOP, controller)
	if event.is_action_pressed(controller.action("ui_down")):
		move_focus(SIDE_BOTTOM, controller)
		
		
func move_focus(side : int, controller : Controller):
	var node = find_valid_focus_neighbor(side)
	if not node:
		return
	if not node is MultiLayerButton:
		return
	
	node.emit_signal("ControllerAdded", controller)
	emit_signal("ControllerRemoved", controller)


func _on_controller_added(controller : Controller):
	self.add_controller(controller)
	self.render_state()
	
func _on_controller_removed(controller : Controller):
	self.remove_controller(controller)
	self.render_state()


func _on_mouse_entered():
	emit_signal("ControllerAdded", GameState.controllers[64])


func _on_mouse_exited():
	emit_signal("ControllerRemoved", GameState.controllers[64])
