extends ColorRect
class_name Vingette

@export var center : Vector2
@export var radius : float
@export var softness : int
@export var vignette_color : Color

@onready var animation_player := $AnimationPlayer

func screen_to_uv(center : Vector2) -> Vector2:
	return center / get_viewport_rect().size

func set_center(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.center = center
	get_material().set_shader_parameter("center", center)
	
func circle_in(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.set_center(center)
	animation_player.play("CircleIn")
	
func circle_out(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.set_center(center)
	animation_player.play("CircleOut")

