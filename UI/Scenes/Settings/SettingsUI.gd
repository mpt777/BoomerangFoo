extends EtContainer

@export var reload := false
	#set(new_reload):
		#reload = new_reload
		#mount()
		
@export var exit_container : EtContainer

func _ready():
	GameState.settings.load_from_disk()
	mount()

func mount():
	$VBoxContainer/TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/Sound.mount(GameState.settings.settings.setting("sound"))
	$VBoxContainer/TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/Music.mount(GameState.settings.settings.setting("music"))
	$VBoxContainer/TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/SFX.mount(GameState.settings.settings.setting("sfx"))
	
	$VBoxContainer/TabContainer/Video/ScrollContainer/CenterContainer/VBoxContainer/FullScreen.mount(GameState.settings.settings.setting("full_screen"))
	$VBoxContainer/TabContainer/Video/ScrollContainer/CenterContainer/VBoxContainer/VSYNC.mount(GameState.settings.settings.setting("vsync"))
	
	$VBoxContainer/TabContainer/Debug/ScrollContainer/CenterContainer/VBoxContainer/EnemyAttack.mount(GameState.settings.settings.setting("enemy_attack"))
	$VBoxContainer/TabContainer/Debug/ScrollContainer/CenterContainer/VBoxContainer/PrintOrphans.mount(GameState.settings.settings.setting("orphan_node"))

func _on_save__exit_pressed():
	exit()
	GameState.settings.save_to_disk()
	exit_container.enter()


func _on_default_pressed():
	GameState.settings.settings.reset_all()
	print("Reset To Default")
