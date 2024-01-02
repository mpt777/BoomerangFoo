extends Weapon

var FireProjectile = preload("res://Scenes/Projectile/FireProjectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack():
	var bullet = FireProjectile.instantiate()
	bullet.position = global_position
	bullet.rotation = rotation
	$"/root/Signals".emit_signal("add_projectile", bullet)
