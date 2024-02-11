extends Projectile



func _on_attack_component_body_entered(body):
	# todo, peircing, damage
	if body != attack.owner:
		ToBeDeleted.emit()
		queue_free()
