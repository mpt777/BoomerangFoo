extends Area3D
class_name DamageArea


func _on_area_entered(area: Area3D) -> void:
	#print(area)
	if area is HitboxComponent:
		area.damage(Attack.new().constructor(10, Enums.AttackType.FALLING))
	

func _on_body_entered(body: Node3D) -> void:
	return
