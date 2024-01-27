extends Node
class_name Dash

var can_dash : bool = true;

signal EndDash
signal EndDashCooldown

func start_dash() -> void:
	$DashTimer.start()
	$DashCooldown.start()
	can_dash = false

func _on_dash_timer_timeout():
	EndDash.emit()

func _on_dash_cooldown_timeout():
	can_dash = true
	EndDashCooldown.emit()
	
