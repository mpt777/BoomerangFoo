extends EtContainer
class_name GameSettingsUI

func _on_multi_layer_button_controller_pressed(args):
	self._on_multi_layer_button_pressed()
	
func _on_multi_layer_button_pressed():
	GameState.settings.save_to_disk()
	SceneManager.switch_scene("game")



