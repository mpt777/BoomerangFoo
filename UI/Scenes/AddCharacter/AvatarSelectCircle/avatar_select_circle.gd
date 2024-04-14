extends Control
class_name AvatarSelectCircle

#@onready var background = $SubViewportContainer/SubViewport/Background
#@onready var ground = $SubViewportContainer/SubViewport/Background
@onready var viewport = $SubViewportContainer/SubViewport

var avatar_data : AvatarData

func constructor(avatar_data) -> AvatarSelectCircle:
	self.avatar_data = avatar_data
	return self
	
func _ready():
	viewport.add_child(self.avatar_data.avatar.instantiate())

func _on_multi_layer_button_gui_input(event):
	pass
	#print(event)
