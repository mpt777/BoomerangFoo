extends State

var FireProjectile = preload("res://Scenes/Projectile/FireProjectile.tscn")

@export
var body : Node3D

func enter():
	var bullet = FireProjectile.instantiate()
	bullet.position = body.global_position
	bullet.rotation = body.rotation
	$"/root/Signals".emit_signal("add_projectile", bullet)
	Transitioned.emit(self, "Reloading")
	
func exit():
	pass
	
func update(delta : float):
	pass
	
func physics_update(_delta : float):
	pass

