extends Node3D

class_name Movement

@export var body : Character

@export var SPEED := 7.0
@export var DASH_SPEED := 36.0
@export var ACCELERATION := 0.8
@export var FRICTION := 0.5
@export var GRAVITY := 9.8

var current_speed := SPEED
var current_gravity := GRAVITY

func constructor(_body): 
	self.body = _body
	
func move(direction : Vector3) -> void:
	direction *= self.get_speed()
	if direction.length() > 0:
		body.velocity = body.velocity.lerp(direction, ACCELERATION)
	else:
		body.velocity = body.velocity.lerp(Vector3.ZERO, FRICTION)
		
	body.velocity.y -= current_gravity
	self.move_and_slide()
	
func move_and_slide():
	body.move_and_slide()

func dash() -> void:
	current_speed = DASH_SPEED
	current_gravity = 0
	
func end_dash() -> void:
	current_speed = SPEED
	current_gravity = GRAVITY
	
func get_speed() -> float:
	var speed = current_speed
	speed *= self.body.data.stats.get_value("speed", 1)
	return speed
