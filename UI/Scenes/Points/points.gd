extends Control

var POINT_ROW := preload("res://UI/Scenes/Points/PointRow.tscn")
@onready var v_box_container = $VBoxContainer
@onready var color_rect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	#$"/root/Signals".connect("game_over_points_achieved", switch_to_game_over)
	color_rect.color = Game.settings.background_color
	
	for character in Game.players:
		var point_row = POINT_ROW.instantiate().constructor(character as CharacterData)
		v_box_container.add_child(point_row)
	for child in v_box_container.get_children():
		await child.add_new_points()
		if child.has_won():
			switch_to_game_over()
			return
		
	switch_to_game()


func switch_to_game_over():
	SceneManager.switch_scene("gameover")
	

func switch_to_game():
	SceneManager.switch_scene("game")
