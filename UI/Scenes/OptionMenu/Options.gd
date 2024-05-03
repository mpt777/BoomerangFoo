extends Control


func _ready():
	GameState.settings.settings["sound"].bind($TabContainer/Audio/ScrollContainer/CenterContainer/VBoxContainer/Sound/HSlider)
