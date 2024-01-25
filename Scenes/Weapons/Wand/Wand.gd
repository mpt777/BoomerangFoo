extends Weapon

var FireProjectile = preload("res://Scenes/Projectile/FireProjectile.tscn")

var can_attack := true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack():
	if ($StateMachine.current_state.has_method("attack")):
		$StateMachine.current_state.attack()
		
