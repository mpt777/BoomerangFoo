extends CharacterBody3D

class_name Character
var CAMERA_POINT = preload("res://Scenes/Camera/CameraPoint.tscn")

## The basic Character that stiches all components together
var signals := SignalRegister.new()
var anchors := AnchorRegister.new()
var data : CharacterData

var target_position : Vector3

func _ready() -> void:
	self.name = "Character"
	
func kill() -> void:
	queue_free()
	$"/root/Signals".emit_signal("update_character")
	$"/root/Signals".emit_signal("add_camera_point", CAMERA_POINT.instantiate().constructor(global_position))

func avatar() -> Avatar:
	return $AvatarWrapper.avatar
