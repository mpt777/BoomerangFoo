extends PanelContainer
class_name PointRow

var character_data : CharacterData

@onready var color_rect = $MarginContainer/Main/ColorRect

func _ready():
	self.set_color()
	
func set_color():
	color_rect.color = self.character_data.color
	
func constructor(character_data : CharacterData) -> PointRow:
	self.character_data = character_data
	return self
