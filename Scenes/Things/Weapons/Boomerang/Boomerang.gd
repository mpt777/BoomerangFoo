extends Weapon

@export var VELOCITY := 20.0

@onready
var collision_shape = $CollisionShape3D

@onready
var item_drop = $ItemDropComponent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack():
	pass

func throw():
	print("thrown")
	collision_shape.disabled = false
	freeze = false
	reparent(get_tree().get_first_node_in_group("World"))
	apply_impulse(position.direction_to(target_position).normalized() * VELOCITY)
	item_drop.start_timer()

func pickup():
	print("picked up")
	position = Vector3.ZERO
	collision_shape.set_deferred("disabled", true)
	freeze = true
	item_drop.deactivate()
	
