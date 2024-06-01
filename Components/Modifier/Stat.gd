extends Resource
class_name Stat

@export var title : String
var value
var default
var modifiers : Array[Modifier]

func add_modifier(modifier : Modifier) -> void:
	modifier.add(self)
	modifiers.append(modifier)
	
func remove_modifier(modifier : Modifier) -> void:
	if Utils.remove_item(self.modifiers, modifier):
		modifier.remove(self)
		
func get_value(default=null):
	if self.value:
		return self.value
	if self.default:
		return self.default
	return default
	
func constructor(m_title : String, m_default) -> Stat:
	self.title = m_title
	self.default = m_default
	return self


