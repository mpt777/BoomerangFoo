extends Area3D

class_name PickUpComponent

signal PickedUpArea
	
func _on_body_entered(body):
	pass # Replace with function body.


func _on_area_entered(area):
	if not area is ItemDropComponent:
		return
	if not area.is_active:
		return
	emit_signal("PickedUpArea", area)
