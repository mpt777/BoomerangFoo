extends Area3D

class_name HitboxComponent

@export
var health_component : HealthComponent

func damage(attack : Attack):
	health_component.damage(attack)
