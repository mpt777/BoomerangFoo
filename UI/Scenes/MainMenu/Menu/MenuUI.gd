extends EtContainer

@export var settings_container : EtContainer
@export var credits_container : EtContainer
@export var add_character_container : EtContainer

# Called when the node enters the scene tree for the first time.
func _ready():	
	$VBoxContainer/Debug.grab_focus()
	Game.players = []

func _on_debug_pressed():
	Game.players = GameStateDebug.default_character_data()
	Game.start_run()
	
func _on_start_pressed():
	exit()
	add_character_container.enter()


func _on_settings_pressed():
	exit()
	settings_container.enter()


func _on_credits_pressed():
	exit()
	credits_container.enter()


func _on_quit_pressed():
	get_tree().quit() 
