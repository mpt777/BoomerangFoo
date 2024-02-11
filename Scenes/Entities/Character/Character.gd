extends CharacterBody3D

class_name Character

## The basic Character that stiches all components together
var signals := SignalRegister.new()

func _ready():
	signals.register("Character.Kill", kill)


func kill() -> void:
	queue_free()
	$"/root/Signals".emit_signal("refresh_follow_camera")
