extends Node3D
class_name GameLoop

@export var stages : Dictionary = {
	"dev": "res://Scenes/Enviroment/Stages/Stage.tscn"
}

var played_stages : Array = []
var current_stage : String

@onready var stage_container := $StageContainer
@onready var ui_container := $UIContainer

func _ready():
	start_round()
	
	$"/root/Signals".connect("update_character", update_character)

func random_stage() -> String:
	return stages[stages.keys()[randi() % stages.size()]]
	
func select_new_stage() -> String:
	return random_stage()
	
func set_stage() -> void:
	for child in stage_container.get_children():
		if child is Stage:
			child.queue_free()
	
	var stage := load(select_new_stage()).instantiate() as Stage
	stage_container.add_child(stage)
	
func update_character() -> void:
	var characters := get_tree().get_nodes_in_group("Character").filter(func(x): return not x.is_queued_for_deletion())
	
	if len(characters) <= 1:
		end_round()
	
func start_round() -> void:
	set_stage()
	var count_down := load("res://UI/Countdown/CountDown.tscn").instantiate() as CountDown
	count_down.finished.connect(unfreeze_characters)
	ui_container.add_child(count_down)
	count_down.start()
	
func unfreeze_characters() -> void:
	for character in get_tree().get_nodes_in_group("Character"):
		character.set_can_move(true)
	
func end_round() -> void:
	call_deferred("start_round")
	
# Start and End Game
func start_game() -> void:
	pass
	
func end_game() -> void:
	pass
