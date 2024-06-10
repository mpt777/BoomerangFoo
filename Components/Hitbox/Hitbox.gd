extends Area3D

class_name HitboxComponent

@export var health_component : HealthComponent
@export var omit_attack_types : Array[Enums.AttackType] = []

signal damaged

func damage(attack : Attack):
	if attack.type in omit_attack_types:
		return
	health_component.damage(attack)
	$"/root/Signals".emit_signal("camera_shake", CameraShake.new())
	damaged.emit()
	
