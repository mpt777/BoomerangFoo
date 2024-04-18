extends Control



func _on_multi_layer_button_controller_pressed(args):
	self._on_multi_layer_button_pressed()


func _on_multi_layer_button_pressed():
	SceneManager.switch_scene("main")
