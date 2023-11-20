extends Node3D

class_name HandComponent

@export
var target : CharacterBody3D

@export
var RADIUS := 2

var target_position : Vector3 = Vector3.ZERO:
	set(value):
		target_position = value
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	set_positon_around_target()
	
func set_positon_around_target() -> void:
	var dir : Vector3 = (target_position - target.position).normalized()
	position = (dir * RADIUS)
	position.y = target.position.y

	
func _on_player_controller_mouse_movement(extra_arg_0):
	target_position = extra_arg_0 
