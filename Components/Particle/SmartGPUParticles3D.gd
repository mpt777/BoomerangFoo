extends GPUParticles3D
class_name SmartGPUParticles3D


func release() -> void:
	self.emitting = false
	$"/root/Signals".emit_signal("add_particle", self)

func _on_finished():
	self.queue_free()

func _on_fire_projectile_to_be_deleted():
	release()
