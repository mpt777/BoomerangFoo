extends Control

@onready var gpu_particles_2d = $GPUParticles2D
@onready var point_row_point = $PointRowPoint

func set_color(color : Color) -> void:
	point_row_point.color = color
	gpu_particles_2d.position = custom_minimum_size / 2

func emit() -> void:
	gpu_particles_2d.process_material.set_shader_parameter("color", point_row_point.color)
	gpu_particles_2d.emitting = true
