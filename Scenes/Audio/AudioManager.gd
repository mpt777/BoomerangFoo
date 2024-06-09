extends Node

func play_sound_effect(stream : AudioStream) -> void:
	add_et_audio(EtAudio.new().constructor(stream, "SFX"))
	
func add_et_audio(et_audio : EtAudio) -> void:
	add_child(et_audio)
	et_audio.play()
	
func _ready() -> void:
	add_et_audio(EtAudio.new().constructor(load("res://Assets/Music/rock_master.wav"), "Music"))
