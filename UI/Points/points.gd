extends Control

var POINT_ROW := preload("res://UI/Points/point_row.tscn")
@onready var v_box_container = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for character in GameState.players :
		var point_row = POINT_ROW.instantiate().constructor(character as CharacterData)
		v_box_container.add_child(point_row)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
