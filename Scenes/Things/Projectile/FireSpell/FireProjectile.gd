extends Projectile

@onready var n_particles = $SmartGpuParticles3d

func delete():
	if n_particles:
		n_particles.release()
	super.delete()
