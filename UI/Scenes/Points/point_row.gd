extends PanelContainer
class_name PointRow

var character_data : CharacterData

@onready var color_rect = $MarginContainer/Main/ColorRect
@onready var point_nodes = $MarginContainer/Main/Points

func _ready():
	self.set_color()
	self.add_initial_points()
	#self.add_new_points()
	
func set_color():
	color_rect.color = self.character_data.color
	
func constructor(character_data : CharacterData) -> PointRow:
	self.character_data = character_data
	return self
	
func kill_events() -> Array:
	return GameState.events.filter(func(x): return x is KillEvent)
	
func initial_points() -> int:
	return len(kill_events().filter(func(event): 
		return event.killer_character == self.character_data and event.round_index < GameState.round_index
	))
	
func new_points() -> int:
	return len(kill_events().filter(func(event): 
		return event.killer_character == self.character_data and event.round_index >= GameState.round_index
	))
	
func add_initial_points() -> void:
	var initial_points = self.initial_points()
	var index := 0
	for child in point_nodes.get_children():
		if index < initial_points:
			child.set_color(self.character_data.color)
		index += 1

func add_new_points() -> void:
	var initial_points = self.initial_points()
	var new_points = initial_points + self.new_points()
	var index := 0
	for child in point_nodes.get_children():
		if index < initial_points:
			pass
		elif index < new_points:
			child.set_color(self.character_data.color)
			child.emit()
			await get_tree().create_timer(0.5).timeout
		index += 1
