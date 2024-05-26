extends CollisionShape3D
class_name AvatarWrapper
## Avatar Wrapper is added elements for the gameplay version of the avatar

var character : Character
var avatar : Avatar
var original_rotation : Vector3
@onready var n_anchor = $Anchor

func constructor(p_character : Character) -> AvatarWrapper:
	self.character = p_character
	#self.character.anchors.register("RightHand", r_hand_remote)
	self.avatar = self.character.data.avatar.avatar.instantiate()
	self.n_anchor.add_child(avatar)
	self.mount()
	return self

func _ready():
	return

func mount():
	#avatar.n_body_model = avatar.n_body.get_child(0)
	#avatar.n_body.rotation.x = deg_to_rad(-30)
	#original_rotation = avatar.n_body_model.global_rotation
	
	avatar.n_animation.rotation.x = deg_to_rad(-30)
	original_rotation = avatar.n_camera_fix.global_rotation
	

func _physics_process(_delta):
	#position_hand()
	#avatar.r_hand.rotation.x = 0
	#
	#avatar.n_body.global_rotation = original_rotation
	#avatar.n_body_model.rotation.y = character.rotation.y
	
	avatar.n_animation.global_rotation = original_rotation
	avatar.n_camera_fix.rotation.y = character.rotation.y
	
func position_hand():
	if character.target_position:
		avatar.r_hand.look_at(character.target_position,  Vector3.UP)
