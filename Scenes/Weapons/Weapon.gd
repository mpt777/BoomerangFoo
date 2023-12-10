extends RigidBody3D

class_name Weapon

@export
var hand : HandComponent

var target_position : Vector3 = Vector3.ZERO:
	set(value):
		target_position = value
		look_at_target()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func attack():
	pass
	
func throw():
	pass
	
func pickup():
	pass
	
func look_at_target():
	if target_position != Vector3.ZERO:
		look_at(target_position)

