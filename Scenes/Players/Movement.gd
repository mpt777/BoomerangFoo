extends Node3D

class_name Movement

@export
var body : CharacterBody3D

@export
var SPEED := 10
@export
var DASH_SPEED := 100
@export
var ACCELERATION := 0.8
@export
var FRICTION := 0.5
@export
var GRAVITY := 9.8

var current_speed := SPEED

var can_dash := true

func setup(body): 
	self.body = body
	
	
	
func move(direction : Vector3) -> void:
	direction *= current_speed
	if direction.length() > 0:
		body.velocity = body.velocity.lerp(direction, ACCELERATION)
	else:
		body.velocity = body.velocity.lerp(Vector3.ZERO, FRICTION)
		
	body.velocity.y -= GRAVITY

	body.move_and_slide()



func dash() -> void:
	if not can_dash:
		return
	current_speed = DASH_SPEED
	can_dash = false
	$Dash/DashTimer.start()
	$Dash/DashCooldown.start()
	
func _on_dash_timer_timeout():
	current_speed = SPEED

func _on_dash_cooldown_timeout():
	can_dash = true
