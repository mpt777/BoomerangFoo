extends Control

var POINT_ROW := preload("res://UI/Points/point_row.tscn")
@onready var v_box_container = $VBoxContainer
@onready var color_rect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect.color = GameState.settings.background_color
	
	for character in GameState.players :
		var point_row = POINT_ROW.instantiate().constructor(character as CharacterData)
		v_box_container.add_child(point_row)
	for child in v_box_container.get_children():
		await child.add_new_points()
		
	switch_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func switch_scene():
	SceneManager.switch_scene("game")
