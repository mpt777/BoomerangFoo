extends Resource
class_name Stat

@export var title : String
var value
var default
var modifiers : Array[Modifier]

func add_modifier(modifier : Modifier) -> void:
	#var modifier := m_modifier.duplicate()
	modifier.add(self)
	modifiers.append(modifier)
	
func remove_modifier(modifier : Modifier) -> void:
	if Utils.remove_item(self.modifiers, modifier):
		modifier.remove(self)
		
func clear_modifiers() -> void:
	for modifier in self.modifiers:
		modifier.remove(self)
	self.modifiers.clear()
		
func get_value(m_default=null):
	if self.value:
		return self.value
	if self.default:
		return self.default
	return m_default
	
func constructor(m_title : String, m_default, m_modifiers = null) -> Stat:
	self.title = m_title
	self.default = m_default
	if m_modifiers:
		for m_mod in m_modifiers:
			self.add_modifier(m_mod)
	return self


