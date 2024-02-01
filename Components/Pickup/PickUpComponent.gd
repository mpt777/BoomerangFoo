extends Area3D

class_name PickUpComponent
signal PickedUpArea

@export
var character : Character
	
func _on_body_entered(body):
	pass # Replace with function body.

func _on_area_entered(area):
	if area is Pickup:
		area.pickup(character)
