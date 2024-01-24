extends Area3D

class_name AttackComponent

@export
var damage := 1.0

func attack() -> Attack:
	var a = Attack.new()
	a.damage = damage
	return a

func _on_area_entered(area):
	if area is HitboxComponent:
		area.damage(attack())
