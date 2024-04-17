extends PanelContainer
class_name CharacterCircle

@onready
var avatar_container = $SubViewportContainer/SubViewport/AvatarContainer

@onready
var viewport_container = $SubViewportContainer

var character_data : CharacterData


func constructor(character_data : CharacterData):
	self.character_data = character_data
	
	
func set_color(color : Color) -> void:
	viewport_container.material.set_shader_parameter("color", color)
	
func set_avatar(avatar_data : AvatarData):
	self.character_data.avatar = avatar_data
	for child in avatar_container.get_children():
		child.queue_free()
	avatar_container.add_child(self.character_data.avatar.avatar.instantiate())
	#self.set_color(self.character_data.avatar.color)
