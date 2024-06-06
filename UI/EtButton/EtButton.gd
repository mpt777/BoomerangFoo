extends Button
class_name EtButton

@export var sound : EtButtonResourceSound


func _on_focus_entered() -> void:
	if self.sound:
		AudioManager.play_sound_effect(self.sound.stream)
