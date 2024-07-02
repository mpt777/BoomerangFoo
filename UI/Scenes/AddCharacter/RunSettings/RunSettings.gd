extends EtContainer
class_name RunSettingsUI

@export var prev_et_container : EtContainer

func _on_multi_layer_button_controller_pressed(_args):
	self._on_multi_layer_button_pressed()
	
func _on_multi_layer_button_pressed():
	Game.settings.save_to_disk()
	Game.start_run()



