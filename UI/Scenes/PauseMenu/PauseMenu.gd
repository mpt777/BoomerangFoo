extends EtContainer

@export var settings_container : EtContainer
@onready var settings_ui = $"../SettingsUI"

func _input(event):
	for index in GameState.controllers:
		var controller : Controller = GameState.controllers[index]
		process_input(event, controller)
			
func process_input(event : InputEvent, controller: Controller):
	if event.is_action_released(controller.action("escape")):
		self._toggle()
		
func _toggle():
	if settings_ui.visible:
		settings_ui.exit()
		self.enter()
		return
		
	if self.visible:
		self.quit()
	else:
		self.enter()
		self.pause(true)
		
func quit() -> void:
	self.exit()
	self.pause(false)
	
func pause(paused: bool) -> void:
	get_tree().paused = paused
		
func _on_resume_controller_pressed(controller: Controller) -> void:
	self.quit()
	
func _on_settings_controller_pressed(controller: Controller) -> void:
	self.exit()
	settings_container.enter()
	
func _on_title_controller_pressed(controller: Controller) -> void:
	self.quit()
	SceneManager.switch_scene("main")
	
func _on_desktop_controller_pressed(controller: Controller) -> void:
	self.quit()
	get_tree().quit()
