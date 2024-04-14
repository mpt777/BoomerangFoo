extends Control
class_name AvatarSelect

@onready var n_grid = $GridContainer
var AVATAR_SELECT_CIRCLE := preload("res://UI/Scenes/AddCharacter/AvatarSelectCircle/avatar_select_circle.tscn")


func _ready():
	add_avatar_selects()
	
func add_avatar_selects() -> void:
	for avatar in GameProfile.avatars:
		self.add_avatar_select(avatar)
		
func add_avatar_select(avatar : AvatarData) -> void:
	var avatar_select : AvatarSelectCircle = AVATAR_SELECT_CIRCLE.instantiate().constructor(avatar)
	n_grid.add_child(avatar_select)
	
func random_avatar() -> AvatarSelectCircle:
	var count := n_grid.get_child_count()
	return n_grid.get_child(randi() % count) as AvatarSelectCircle
