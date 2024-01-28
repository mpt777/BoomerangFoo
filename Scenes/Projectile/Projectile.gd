extends Area3D

class_name Projectile

var direction: Vector3 = Vector3.ZERO
var speed: float = 30.0
var weapon: Weapon
var weapon_owner: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _physics_process(delta):
	position += -transform.basis.z * speed * delta
