extends Area3D
class_name AttackComponent

@export var damage := 1.0

var attack : Attack

#when this attack component attacks somthing, this is emitted
signal attacked
signal collided
	
func set_attack(character : CharacterData) -> Attack:
	var a = Attack.new()
	a.damage = damage
	a.character = character
	self.attack = a
	return self.attack
	
func _on_area_entered(area):
	if area is HitboxComponent:
		#print(area.owner.data, a.character, area.owner.data==a.character)
		if area.owner is Character:
			if area.owner.data != self.attack.character:
				area.damage(self.attack)
				attacked.emit()
		else:
			area.damage(self.attack)
			attacked.emit()


func _on_body_entered(body: Node3D) -> void:
	collided.emit()
