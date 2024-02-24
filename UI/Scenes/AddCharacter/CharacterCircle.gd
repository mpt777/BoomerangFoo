extends TextureRect
class_name CharacterCircle


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_color(color : Color) -> void:
	print(material)
	material.set_shader_parameter("color", color)
