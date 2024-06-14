extends Movement

@export var nav_agent : NavigationAgent3D

func move_and_slide():
	nav_agent.set_velocity(body.velocity)


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	body.velocity = safe_velocity
	body.move_and_slide()
