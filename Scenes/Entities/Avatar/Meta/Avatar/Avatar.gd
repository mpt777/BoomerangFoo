extends Node3D
class_name Avatar

var n_body_model : Node3D
@onready var n_body : Node3D = $Body
@onready var r_hand : Node3D = $Right
@onready var r_hand_remote : Node3D = $Right/RemoteTransform3D

#func _ready():
	#print("here")
