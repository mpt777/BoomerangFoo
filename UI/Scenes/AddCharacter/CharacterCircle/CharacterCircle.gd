extends PanelContainer
class_name CharacterCircle

@onready
var avatar_container = $SubViewportContainer/SubViewport/AvatarContainer

@onready
var viewport_container = $SubViewportContainer

var character_data : CharacterData


func constructor(p_character_data : CharacterData):
	self.character_data = p_character_data
	
	
func set_color(color : Color) -> void:
	viewport_container.material.set_shader_parameter("color", color)
	
func set_avatar(p_avatar_data : AvatarData):
	self.character_data.avatar = p_avatar_data
	for child in avatar_container.get_children():
		child.queue_free()
	avatar_container.add_child(self.character_data.avatar.avatar.instantiate())
	$"/root/Signals".emit_signal("avatar_attached_to_character", self.character_data)
	#self.set_color(self.character_data.avatar.color)
