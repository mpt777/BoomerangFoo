extends Node

#when a chacters is added or deleted in a stage
signal update_character()
#turns the camera's ability to follow "active objects" on and off
signal set_follow_camera_active(active : bool)

#emitted when a round is started.
signal start_round()

signal add_projectile(projectile : Projectile)
signal add_particle(particle : SmartGPUParticles3D)

signal add_event(event : Event)
signal camera_shake(camera_shake : CameraShake)
signal add_camera_point(cm : CameraPoint)


#Usually when a new controller is added or removed
signal players_changed()
signal controllers_changed(controller : Controller, connected : bool)


# UI
signal avatar_selected(controller : Controller, avatar_data: AvatarData)
signal avatar_attached_to_character(character : CharacterData)
signal add_bot()
signal remove_bot()

#PointScreen
signal game_over_points_achieved()
