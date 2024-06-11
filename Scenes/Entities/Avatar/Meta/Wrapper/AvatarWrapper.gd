extends CollisionShape3D
class_name AvatarWrapper
## Avatar Wrapper is added elements for the gameplay version of the avatar

var character : Character
var avatar : Avatar
var original_rotation : Vector3
var hand_rot : Vector3
@onready var n_anchor = $Anchor

func constructor(p_character : Character) -> AvatarWrapper:
	self.character = p_character
	self.avatar = self.character.data.avatar.avatar.instantiate()
	self.n_anchor.add_child(self.avatar)
	self.character.anchors.register(self.avatar.n_right_hand_remote)
	self.mount()
	return self

func _ready():
	self.name = "AvatarWrapper"

func mount():
	# Save the original global rotation
	hand_rot = avatar.n_right_hand.global_rotation
	
	#original rotation offser
	avatar.n_animation.rotation.x = deg_to_rad(-35)
	original_rotation = avatar.n_camera_fix.global_rotation
	
	

func _physics_process(_delta):
	# reset the to rotation to the original, and pass along the charatcer rotation
	avatar.n_right_hand.global_rotation = hand_rot
	avatar.n_right_hand.global_rotation.y = character.rotation.y
	
	#original rotation offser
	avatar.n_animation.global_rotation = original_rotation
	avatar.n_camera_fix.rotation.y = character.rotation.y
