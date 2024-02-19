extends Node

signal add_projectile(projectile : Projectile)
signal add_particle(particle : SmartGPUParticles3D)

signal update_character()
signal set_follow_camera_active(active : bool)

signal add_event(event : Event)

signal start_round()
#signal add_event()

signal camera_shake(camera_shake : CameraShake)


signal ui_finished()
