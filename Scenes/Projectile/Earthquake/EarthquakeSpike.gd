extends Projectile

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(n_attack, "position", Vector3(0,0,0), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.end_attack)
	tween.tween_property(n_attack, "position", Vector3(0,0,0), 1)
	tween.tween_property(n_attack, "position", Vector3(0,-1,0), 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.queue_free)
	
func end_attack():
	n_attack.monitoring = false
