extends Node3D
class_name CharacterPointer

@onready var n_sprite = $Sprite

@export var max_distance := 1.0
@onready var position_tween : Tween

const DISTANCE : float = 3.0
const RESET_DISTANCE : float = 1.0
const TIME : float = 2

func _ready():
	reset()
	
func set_color(color: Color):
	n_sprite.modulate = color
	
func start():
	if position_tween:
		reset()
	visible=true
	position_tween = create_tween()
	position_tween.tween_property(n_sprite, "position", Vector3(0,0,-DISTANCE), TIME)
	
func reset():
	n_sprite.position = Vector3(0,0,-RESET_DISTANCE)
	if position_tween:
		position_tween.kill()
	visible = false
