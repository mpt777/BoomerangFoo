extends Label3D
class_name CharacterMessage


var seconds : float = 5.0
var color : Color
@onready
var n_sprite := $Sprite3D
@onready
var n_timer := $Timer


func _ready():
	set_color(Color.REBECCA_PURPLE)
	set_seconds(5.0)
	set_text("Debug2")
	
func set_seconds(seconds : float) -> void:
	n_timer.wait_time = seconds

func set_color(color: Color) -> void:
	var gradient_data := {
		0.0: Color.RED,
		0.5: Color.GREEN,
		0.75: Color.VIOLET,
		1.0: Color.BLUE,
	}

	var gradient := Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()

	var gradient_texture := GradientTexture1D.new()
	gradient_texture.gradient = gradient
	gradient_texture.width = 3

	n_sprite.texture = gradient_texture

func _on_timer_timeout() -> void:
	self.queue_free()
