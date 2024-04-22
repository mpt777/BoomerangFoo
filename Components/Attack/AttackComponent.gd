extends Area3D

class_name AttackComponent

@export var damage := 1.0

var attack : Attack

#when this attack component attacks somthing, this is emitted
signal attacked
signal collided

func base_attack() -> Attack:
	var a = Attack.new()
	a.damage = damage
	return a
	
func get_attack() -> Attack:
	if self.attack:
		return self.attack
	return self.base_attack()

func _on_area_entered(area):
	if area is HitboxComponent:
		var a := get_attack()
		#print(area.owner.data, a.character, area.owner.data==a.character)
		var x = area.owner
		if area.owner is Character:
			if area.owner.data != a.character:
				area.damage(a)
				attacked.emit()
		else:
			area.damage(a)
			attacked.emit()


func _on_body_entered(body):
	collided.emit()
