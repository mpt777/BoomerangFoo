extends RigidBody3D

class_name Weapon

@export var weapon_owner : Character
@export var spawn_point : Node3D
@export var anchor : String
	#set(value):
		#target_position = value
		#look_at_target()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func attack() -> void:
	pass
	
func throw():
	pass
	
func pickup():
	pass
	
func spawn_node() -> Node3D:
	return spawn_point
	
#func look_at_target():
	#if target_position != Vector3.ZERO && abs(target_position.x) > 0.99:
		#look_at(target_position)
	#rotation.x = 0

