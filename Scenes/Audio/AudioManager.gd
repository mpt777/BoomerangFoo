extends Node

@onready var n_player = $AudioStreamPlayer

func play_sound_effect(stream : AudioStream) -> void:
	n_player.stream = stream
	n_player.play()
