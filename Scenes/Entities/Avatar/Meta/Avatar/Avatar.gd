extends Node3D
class_name Avatar

#var n_body_model : Node3D
#@onready var n_body : Node3D = $Body/CameraFix
#@onready var r_hand : Node3D = $Right
#@onready var r_hand_remote : Node3D = $Right/RemoteTransform3D

@onready var n_camera_fix : Node3D = $Animation/CameraFix
@onready var n_animation : Node3D = $Animation
@onready var state_machine = $AnimationTree.get("parameters/playback")

@onready var n_blend_tree = $BlendTree

@onready var n_right_hand = $Animation/CameraFix/Right
@onready var n_right_hand_remote = $Animation/CameraFix/Right/RemoteTransform3D
@export var anchors : Array[Anchor]

func _ready():
	self.name = "Avatar"
	n_blend_tree.active = true
#var tween = EtTween.new()
	
func travel(state : String) -> void:
	state_machine.travel(state)
	

func walk_idle(value : float) -> void:
	create_tween().tween_method(
		func(v: float) -> void: n_blend_tree.set("parameters/WalkIdle/blend_amount", v),
		n_blend_tree.get("parameters/WalkIdle/blend_amount"),
		value, 0.3
	)
	#n_blend_tree.set("parameters/WalkIdle/blend_amount", value)
	
func cast(travel : String) -> void:
	n_blend_tree.get("parameters/Cast/playback").travel(travel)
	
