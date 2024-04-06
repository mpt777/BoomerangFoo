extends Node3D
class_name CharacterMessageManager

@onready
var n_control = $Control
@onready
var n_container = $Control/HBoxContainer

var camera : Camera3D
var offset := Vector2.ZERO
var screen_size := Vector2.ZERO

func _ready():
	camera = get_viewport().get_camera_3d()
	screen_size = get_viewport().size
	offset = Vector2.ZERO
	position_message()
	
	$"/root/Signals".connect("start_round", start_messages)
	owner.signals.register("Message.AddMessage", add_message)
	
func _process(delta):
	position_message()
	
func position_message() -> void:
	n_control.position = Vector2(camera.unproject_position(global_position))
	offset = Vector2(0, -10)
	n_control.position += offset
	
func add_message(message : CharacterMessage) -> void:
	n_container.add_child(message)
	
func start_messages() -> void:
	for message in n_container.get_children():
		message = message as CharacterMessage
		message.start_timer()
