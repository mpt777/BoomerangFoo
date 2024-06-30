extends EtContainer
class_name AvatarSelect

var AVATAR_SELECT_CIRCLE := preload("res://UI/Scenes/AddCharacter/AvatarSelectCircle/AvatarSelectCircle.tscn")

@onready var n_grid = $VBoxContainer/AvatarGrid
@onready var n_ready_button = $VBoxContainer/ReadyButton

@export var next_et_container : EtContainer

func _ready():
	for avatar in GameProfile.avatars:
		self.add_avatar_select(avatar)
	$"/root/Signals".connect("avatar_attached_to_character", avatar_attached_to_character)
		
func add_avatar_select(avatar : AvatarData) -> void:
	var avatar_select : AvatarSelectCircle = AVATAR_SELECT_CIRCLE.instantiate().constructor(avatar)
	n_grid.add_child(avatar_select)
	
func random_avatar() -> AvatarSelectCircle:
	var count := n_grid.get_child_count()
	return n_grid.get_child(randi() % count) as AvatarSelectCircle
	
func avatar_attached_to_character(_character : CharacterData):
	for player in Game.players:
		if not player.avatar:
			hide_button()
			return
	show_button()
	
func show_button() -> void:
	n_ready_button.visible = true
	
func hide_button() -> void:
	n_ready_button.visible = false

func _on_ready_button_controller_pressed(_controller : Controller):
	self.next_et_container.enter()
	self.exit()


