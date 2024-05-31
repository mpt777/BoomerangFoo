extends Node3D

class_name HealthComponent

@export var max_health := 1.0
var health := 1.0

signal killed
signal damaged

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
func damage(attack : Attack):
	health -= attack.damage
	if health <= 0 and not dead:
		killed.emit(attack)
		dead = true
		kill()
			
func kill() -> void:
	get_parent().queue_free()
