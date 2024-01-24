extends Node3D

class_name HealthComponent

@export 
var max_health := 1.0
var health := 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health

func damage(attack : Attack):
	health -= attack.damage
	if health <= 0:
		kill()
	
func kill():
	get_parent().queue_free()
