extends State

var FireProjectile = preload("res://Scenes/Projectile/FireProjectile.tscn")

@export
var body : Node3D

func enter():
	body.can_attack = false
	
func exit():
	pass
	
func update(delta : float):
	if body.can_attack:
		attack()
		body.can_attack = false
		
func physics_update(_delta : float):
	pass
	
func attack():
	var bullet = FireProjectile.instantiate()
	bullet.position = body.global_position
	bullet.rotation = body.rotation
	$"/root/Signals".emit_signal("add_projectile", bullet)
	Transitioned.emit(self, "Reloading")
	
