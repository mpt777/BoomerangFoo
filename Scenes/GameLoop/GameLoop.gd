extends Node3D
class_name GameLoop

@export var stages : Dictionary = {
	#"dev": "res://Scenes/Stage/StageElements/Stage.tscn",
	"graveyard": "res://Scenes/Stage/Stages/Graveyard/GraveyardStage.tscn"
}

var current_stage : String

@onready var stage_container := $StageContainer
@onready var ui_container := $UIContainer
@onready var ui_vignette := $UIContainer/Vignette

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
	
func start_round() -> void:
	set_stage()
	start_count_down()
	start_vignette()
	$"/root/Signals".emit_signal("start_round")
	
func end_round() -> void:
	end_vignette()
	
#func _input(event):
	#print(event)
	#
#func _unhandled_input(event):
	#print(event)
	

func _on_vignette_end_vignette_end():
	SceneManager.switch_scene("points")


func start_vignette() -> void:
	ui_vignette.blank_screen()
	ui_vignette.circle_out()
	
func end_vignette():
	set_can_move_characters(false)
	$"/root/Signals".emit_signal("set_follow_camera_active", false)
	var characters := get_tree().get_nodes_in_group("Character").filter(func(x): return not x.is_queued_for_deletion())
	if characters:
		var character_position := get_viewport().get_camera_3d().unproject_position(characters[0].global_position) as Vector2
		ui_vignette.circle_in(ui_vignette.screen_to_uv(character_position))
	else:
		ui_vignette.circle_in(ui_vignette.screen_center())
		
func start_count_down():
	var count_down := load("res://UI/Countdown/CountDown.tscn").instantiate() as CountDown
	count_down.finished.connect(unfreeze_characters)
	ui_container.add_child(count_down)
	count_down.start()
	
	
	
	
	
	
func update_character() -> void:
	var characters := get_tree().get_nodes_in_group("Character").filter(func(x): return not x.is_queued_for_deletion())
	if len(characters) <= 1:
		end_round()
	
func unfreeze_characters():
	set_can_move_characters(true)
	
func set_can_move_characters(can_move : bool) -> void:
	for character in get_tree().get_nodes_in_group("Character"):
		if can_move:
			character.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			character.process_mode = Node.PROCESS_MODE_DISABLED
		#character.set_can_move(can_move)
	


	
# Start and End Game
func start_game() -> void:
	pass
	
func end_game() -> void:
	pass



