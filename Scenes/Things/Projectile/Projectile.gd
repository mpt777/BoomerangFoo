extends Area3D

class_name Projectile

#var direction: Vector3 = Vector3.ZERO
@export
var speed: float = 30.0
var weapon: Weapon
var weapon_owner: Node
var attack : Attack


signal ToBeDeleted

# Called when the node enters the scene tree for the first time.
func _ready():
	set_attack_component()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	position += -transform.basis.z * speed * delta
	
func direction() -> Vector3:
	return rotation
	
# Description
# Current Hack to set attacks ez
func set_attack_component() -> void:
	for child in get_children():
		if child is AttackComponent:
			child.attack = self.attack
	
#func deleted():
	#pass
