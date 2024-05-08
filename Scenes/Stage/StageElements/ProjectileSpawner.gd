extends Node

func _ready():
	$"/root/Signals".connect("add_projectile", _on_add_projectile)
	$"/root/Signals".connect("add_particle", _on_add_particle)

func _on_add_projectile(projectile):
	add_child(projectile)
	
func _on_add_particle(projectile):
	projectile.reparent(self)
