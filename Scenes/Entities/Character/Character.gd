extends CharacterBody3D

class_name Character

## The basic Character that stiches all components together
var signals := SignalRegister.new()
var data : CharacterData

func _ready():
	signals.register("Character.Kill", kill)
	
func kill() -> void:
	queue_free()
	$"/root/Signals".emit_signal("update_character")
