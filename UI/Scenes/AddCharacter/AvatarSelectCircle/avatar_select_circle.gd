extends Control
class_name AvatarSelectCircle

#@onready var background = $SubViewportContainer/SubViewport/Background
#@onready var ground = $SubViewportContainer/SubViewport/Background
@onready var viewport = $SubViewportContainer/SubViewport
@onready var button = $MultiLayerButton

var avatar_data : AvatarData

func constructor(avatar_data) -> AvatarSelectCircle:
	self.avatar_data = avatar_data
	return self
	
func _ready():
	viewport.add_child(self.avatar_data.avatar.instantiate())

func _on_multi_layer_button_controller_pressed(controller : Controller) -> void:
	$"/root/Signals".emit_signal("select_avatar", controller, self.avatar_data)
