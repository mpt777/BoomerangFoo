extends HBoxContainer
class_name CharacterList

func _ready():
	$"/root/Signals".connect("select_avatar", select_avatar)
	
func find_character_circle(controller: Controller) -> CharacterCircle:
	var player_character_circles = self.get_children().filter(func (x): return x.character_data is PlayerData)
	var character_circles = player_character_circles.filter(func (x): return x.character_data.controller == controller)
	return character_circles[0]

func select_avatar(controller: Controller, avatar_data: AvatarData) -> void:
	var character_circle = find_character_circle(controller) 
	character_circle.set_avatar(avatar_data)
