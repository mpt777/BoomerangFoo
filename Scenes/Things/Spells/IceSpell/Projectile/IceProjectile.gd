extends Projectile


func _on_attack_component_body_entered(body):
	# todo, peircing, damage
	if body is Character:
		if body.data == attack.character:
			return
	ToBeDeleted.emit()
	queue_free()
