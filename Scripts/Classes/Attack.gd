class_name Attack

var damage := 1.0
var type : Enums.AttackType = Enums.AttackType.WATER
var character : CharacterData

func constructor(m_damage := 1, m_type: Enums.AttackType = Enums.AttackType.WATER, m_character=null) -> Attack:
	self.damage = m_damage
	self.type = m_type
	self.character = m_character
	return self 
