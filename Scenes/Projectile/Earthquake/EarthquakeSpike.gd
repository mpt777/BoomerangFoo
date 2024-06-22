extends Projectile
class_name EarthquakeProjectile

@onready var n_particles = $SmartGpuParticles3d
var radius : float

func _ready() -> void:
	self.pierce = 100
	set_radius()
	
	n_particles.emitting = true
	
	var tween = create_tween()
	tween.tween_property(n_attack, "position", Vector3(0,-0.5,0), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.end_attack)
	tween.tween_property(n_attack, "position", Vector3(0,-2,0), 3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.queue_free)
	
func end_attack():
	n_attack.monitoring = false
	n_particles.emitting = false
	
func set_radius():
	$AttackComponent/CollisionShape3D.shape.radius = self.radius
	$AttackComponent/MeshInstance3D.mesh.top_radius = self.radius
	$AttackComponent/MeshInstance3D.mesh.bottom_radius = self.radius
	$SmartGpuParticles3d.process_material.emission_shape_scale = Vector3(self.radius, 0, self.radius)
