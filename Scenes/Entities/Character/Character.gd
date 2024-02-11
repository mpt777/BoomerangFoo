extends CharacterBody3D

class_name Character

## The basic Character that stiches all components together
var signals := SignalRegister.new()
var can_move := false

func _ready():
	signals.register("Character.Kill", kill)

func set_can_move(can_move : bool):
	self.can_move = can_move
	
func kill() -> void:
	queue_free()
	$"/root/Signals".emit_signal("refresh_follow_camera")
	$"/root/Signals".emit_signal("update_character")
