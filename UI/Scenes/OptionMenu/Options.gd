extends Control

@export var reload := false:
	set(new_reload):
		reload = new_reload
		mount()

func _ready():
	GameState.settings.load_from_disk()
	mount()

func mount():
	$TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/Sound.mount(GameState.settings.settings["sound"])
	$TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/Music.mount(GameState.settings.settings["music"])
	$TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/SFX.mount(GameState.settings.settings["sfx"])
	$TabContainer/Video/ScrollContainer/CenterContainer/VBoxContainer/FullScreen.mount(GameState.settings.settings["full_screen"])
	
	$TabContainer/Debug/ScrollContainer/CenterContainer/VBoxContainer/EnemyAttack.mount(GameState.settings.settings["enemy_attack"])

func _input(event):
	if Input.is_key_pressed(KEY_K):
		GameState.settings.save_to_disk()
