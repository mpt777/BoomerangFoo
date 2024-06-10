extends AudioStreamPlayer
class_name EtAudio


func constructor(stream : AudioStream, bus : String) -> EtAudio:
	self.name = "EtAudio"
	self.set_stream(stream)
	self.set_bus(bus)
	return self


func _on_finished() -> void:
	queue_free()
