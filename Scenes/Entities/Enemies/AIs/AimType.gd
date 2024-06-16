extends Resource
class_name AimType

@export var leading_weight : float = 1.0
@export var rotation_speed : float = 0.8
@export var max_lead : float = 50

func constructor(m_leading_weight: float, m_rotation_speed = 0.8) -> AimType:
	self.leading_weight = m_leading_weight
	self.rotation_speed = m_rotation_speed
	return self
