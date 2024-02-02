extends Node

func _ready():
	$"/root/Signals".connect("add_projectile", _on_add_projectile)

func _on_add_projectile(projectile):
	add_child(projectile)
