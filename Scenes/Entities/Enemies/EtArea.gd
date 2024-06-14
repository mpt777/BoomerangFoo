extends Area3D
class_name EtArea

var areas : Array
var bodies : Array

func _on_area_entered(area: Area3D) -> void:
	self.areas.append(area)

func _on_area_exited(area: Area3D) -> void:
	if area in self.areas:
		Utils.remove_item(self.areas, area)

func _on_body_entered(body: Node3D) -> void:
	self.bodies.append(body)

func _on_body_exited(body: Node3D) -> void:
	if body in self.bodies:
		Utils.remove_item(self.bodies, body)
