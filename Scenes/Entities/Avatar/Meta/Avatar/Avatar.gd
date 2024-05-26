extends Node3D
class_name Avatar

#var n_body_model : Node3D
#@onready var n_body : Node3D = $Body/CameraFix
#@onready var r_hand : Node3D = $Right
#@onready var r_hand_remote : Node3D = $Right/RemoteTransform3D

@onready var n_camera_fix : Node3D = $Animation/CameraFix
@onready var n_animation : Node3D = $Animation

@onready var state_machine = $AnimationTree.get("parameters/playback")

#func _ready():
	#print("here")
	
func travel(state : String) -> void:
	state_machine.travel(state)
