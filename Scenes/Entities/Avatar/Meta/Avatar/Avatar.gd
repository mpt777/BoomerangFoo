extends Node3D
class_name Avatar

var character : Character

@onready
var n_pivot = $Avatar/Body

@onready
var n_body = $Avatar/Body/robot_body

@onready
var r_hand = $Avatar/Right

@onready
var r_hand_remote = $Avatar/Right/RemoteTransform3D

var original_rotation : Vector3

func _ready():
	var n = self
	while not n is Character:
		n = n.get_parent()
	character = n
	character.anchors.register("RightHand", r_hand_remote)
	
	n_pivot.rotation.x = deg_to_rad(-30)
	original_rotation = n_body.global_rotation

func _physics_process(delta):
	position_hand()
	r_hand.rotation.x = 0
	
	n_pivot.global_rotation = original_rotation
	n_body.rotation.y = character.rotation.y
	
func position_hand():
	if character.target_position:
		r_hand.look_at(character.target_position,  Vector3.UP)
		
