extends TextureRect
class_name CharacterCircle

var character_data : CharacterData

func constructor(character_data : CharacterData):
	self.character_data = character_data
	self.set_color(character_data.color)
	
func set_color(color : Color) -> void:
	material.set_shader_parameter("color", color)
	
func set_avatar(avatar_data : AvatarData):
	print("Do Avatar Update THings")
	self.character_data.avatar = avatar_data
