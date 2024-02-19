extends ColorRect
class_name Vingette

@export var center : Vector2
@export var radius : float
@export var softness : int
@export var vignette_color : Color

@onready var animation_player := $AnimationPlayer

signal end_vignette_end

func _ready():
	color = GameState.settings.background_color
	self.set_shader_color(GameState.settings.background_color)
	
func set_shader_color(color : Color):
	color = GameState.settings.background_color
	get_material().set_shader_parameter("color", color)

func screen_to_uv(center : Vector2) -> Vector2:
	return center / get_viewport_rect().size
	
func screen_center(center : Vector2) -> Vector2:
	return get_viewport_rect().size / 2

func set_center(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.center = center
	get_material().set_shader_parameter("center", center)
	
func blank_screen(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.set_center(center)
	get_material().set_shader_parameter("diameter_factor", 0)

func circle_in(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.set_center(center)
	animation_player.play("CircleIn")
	
func circle_out(center: Vector2 = Vector2(0.5, 0.5)) -> void:
	self.set_center(center)
	animation_player.play("CircleOut")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	if anim_name == "CircleIn":
		end_vignette_end.emit()
