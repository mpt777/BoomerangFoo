extends Node3D
class_name CameraPoint

var start_position : Vector3
var target_position : Vector3 = Vector3.ZERO
var speed : float = 5

func _ready() -> void:
	$"/root/Signals".emit_signal("update_character")
	
	if self.start_position != Vector3.ZERO:
		self.global_position = self.start_position
	self.global_position.y = 0
	self.look_at(self.target_position)
	
	
func _physics_process(delta: float) -> void:
	self.global_position += (self.global_position.direction_to(self.target_position)).normalized() * self.speed * delta
	if (self.global_position - target_position).length() < 2:
		self.queue_free()

func constructor(m_gp : Vector3, m_target_position : Vector3 = Vector3.ZERO, m_speed : float = 10) -> CameraPoint:
	self.start_position = m_gp
	self.target_position = m_target_position
	self.speed = m_speed
	return self
