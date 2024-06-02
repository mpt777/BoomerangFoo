extends PanelContainer
class_name PointRow

@onready var color_rect = $MarginContainer/Main/ColorRect
@onready var n_points_container = $MarginContainer/Main/Points

var character_data : CharacterData
var POINT_ROW_POINT = preload("res://UI/Scenes/Points/PointRowPoint.tscn")

func _ready():
	self.add_point_nodes()
	self.set_color()
	self.add_initial_points()
	#self.add_new_points()
	
func constructor(_character_data : CharacterData) -> PointRow:
	self.character_data = _character_data
	return self
	
func set_color() -> void:
	color_rect.color = self.character_data.color
	
func add_point_nodes() -> void:
	for _i in range(GameState.settings.points_per_round):
		n_points_container.add_child(POINT_ROW_POINT.instantiate())
	
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
	var _initial_points = self.initial_points()
	var index := 0
	for child in n_points_container.get_children():
		if index < _initial_points:
			child.set_color(self.character_data.color)
		index += 1

func add_new_points() -> void:
	var _initial_points = self.initial_points()
	var _new_points = _initial_points + self.new_points()
	var index := 0
	for child in n_points_container.get_children():
		if index < _initial_points:
			pass
		elif index < _new_points:
			child.set_color(self.character_data.color)
			child.emit()
			await get_tree().create_timer(0.5).timeout
		index += 1
		
func has_won() -> bool:
	return self.initial_points() + self.new_points() >= GameState.settings.points_per_round
