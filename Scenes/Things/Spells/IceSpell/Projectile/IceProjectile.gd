extends Projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_component_body_entered(body):
	# todo, peircing, damage
	ToBeDeleted.emit()
	queue_free()