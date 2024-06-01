extends State

@export var mesh : VisualInstance3D
var _overlay : Material = preload("res://Scenes/MaterialOverrides/Damaged/damaged.tres")
var overlay : Material

func enter():
	overlay = _overlay.duplicate()
	mesh.set_material_overlay(overlay)
	var tween := create_tween()
	
	var alpha : float = overlay.albedo_color.a
	var color : Color = Color(overlay.albedo_color.r, overlay.albedo_color.g, overlay.albedo_color.b, 0.0)
	var end_color : Color = Color(overlay.albedo_color.r, overlay.albedo_color.g, overlay.albedo_color.b, alpha)
	overlay.albedo_color = color
	tween.tween_property(overlay, "albedo_color", end_color, 0.2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(overlay, "albedo_color", color, 0.3).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(self.end)
	
func end() -> void:
	mesh.set_material_overlay(null)
	Transitioned.emit(self, "Idle")
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

func _input(_event):
	pass

