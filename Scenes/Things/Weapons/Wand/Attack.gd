extends State

var FireProjectile = preload("res://Scenes/Things/Projectile/FireProjectile.tscn")

signal Attacked

@export
var body : Node3D

func enter():
	var bullet = FireProjectile.instantiate()
	bullet.position = body.global_position
	bullet.rotation = body.rotation
	bullet.weapon = body
	bullet.weapon_owner = body.weapon_owner
	$"/root/Signals".emit_signal("add_projectile", bullet)
	Transitioned.emit(self, "Reloading")
	Attacked.emit()
	
func exit():
	pass
	
func update(delta : float):
	pass
	
func physics_update(_delta : float):
	pass

