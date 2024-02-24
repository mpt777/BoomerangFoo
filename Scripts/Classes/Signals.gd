extends Node

signal add_projectile(projectile : Projectile)
signal add_particle(particle : SmartGPUParticles3D)

#when a chacters is added or deleted in a stage
signal update_character()
signal set_follow_camera_active(active : bool)

signal add_event(event : Event)

signal start_round()


signal camera_shake(camera_shake : CameraShake)


#Usually when a new controller is added or removed
signal players_changed()
signal controllers_changed(id : int, connected : bool)
