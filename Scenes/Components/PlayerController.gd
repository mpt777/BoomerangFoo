extends Controller

@export
var target : CharacterBody3D

@export
var SPEED := 10

@export
var ACCELERATION := 0.8

@export
var FRICTION := 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	register_action("move_up", InputEventKey.new(), KEY_W)
	register_action("move_down", InputEventKey.new(), KEY_S)
	register_action("move_left", InputEventKey.new(), KEY_A)
	register_action("move_right", InputEventKey.new(), KEY_D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if not target:
		return
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	var target_velocity = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed(action("move_right")):
		direction.x += 1
	if Input.is_action_pressed(action("move_left")):
		direction.x -= 1
	if Input.is_action_pressed(action("move_down")):
		direction.z += 1
	if Input.is_action_pressed(action("move_up")):
		direction.z -= 1
		
	direction = direction.normalized() * SPEED
	
	if direction.length() > 0:
		target.velocity = target.velocity.lerp(direction, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		target.velocity = target.velocity.lerp(Vector3.ZERO, FRICTION)

	target.move_and_slide()
