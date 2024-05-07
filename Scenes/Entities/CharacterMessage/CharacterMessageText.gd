extends CharacterMessage
class_name CharacterMessageText

@onready
var n_label : Label = $MarginContainer/Label

@onready
var n_color : ColorRect = $ColorRect

var _text := ""
var _color : Color = Color.REBECCA_PURPLE

func constructor(p_text: String, p_color : Color):
	self._text = p_text
	self._color = p_color

func _ready():
	self.set_color(self._color)
	self.set_text(self._text)
	self.start_timer()
	
func set_text(text: String) -> void:
	n_label.set_text(text)

func set_color(p_color: Color) -> void:
	n_color.color = p_color
	#var gradient_data := {
		#0.0: Color.RED,
		#0.5: Color.GREEN,
		#0.75: Color.VIOLET,
		#1.0: Color.BLUE,
	#}
#
	#var gradient := Gradient.new()
	#gradient.offsets = gradient_data.keys()
	#gradient.colors = gradient_data.values()
#
	#var gradient_texture := GradientTexture1D.new()
	#gradient_texture.gradient = gradient
	#gradient_texture.width = 3
#
	#n_color.texture = gradient_texture
