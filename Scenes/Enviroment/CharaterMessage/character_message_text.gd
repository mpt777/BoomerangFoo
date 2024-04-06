extends CharacterMessage
class_name CharacterMessageText

@onready
var n_label : Label = $Label

var _text := ""
var _color : Color = Color.REBECCA_PURPLE

func constructor(text: String, color : Color):
	self._text = text
	self._color = color

func _ready():
	self.set_color(self._color)
	self.set_text(self._text)
	self.start_timer()
	
func set_text(text: String) -> void:
	n_label.set_text(text)

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

	#n_sprite.texture = gradient_texture
