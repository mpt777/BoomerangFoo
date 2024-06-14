extends Resource
class_name Decision

var weight : int
var position : Vector3

func constructor(m_weight : int, m_position : Vector3) -> Decision:
	self.weight = m_weight
	self.position = m_position
	return self
