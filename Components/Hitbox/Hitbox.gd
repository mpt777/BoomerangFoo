extends Area3D

class_name HitboxComponent

@export var health_component : HealthComponent
signal damaged

func damage(attack : Attack):
	health_component.damage(attack)
	$"/root/Signals".emit_signal("camera_shake", CameraShake.new())
	damaged.emit()
	
