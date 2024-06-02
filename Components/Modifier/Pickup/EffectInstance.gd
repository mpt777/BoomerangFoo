extends Resource
class_name EffectInstance

var character_data : CharacterData
var effect : Effect
var node : Node

func apply() -> void:
	if self.character_data.character:
		self.effect.message.emit_message(self.character_data.character)
	if self.effect.node and self.character_data.character:
		self.node = self.effect.node.instance_scene()
		self.character_data.character.add_child(node)
	self.character_data.stats.apply(self.effect.modifier)
	
func remove() -> void:
	for stat in self.character_data.character.data.stats.stats:
		if self.effect.modifier in stat.modifiers:
			stat.remove_modifier(self.effect.modifier)
	if self.node:
		self.node.queue_free()
		
func add_node() -> void:
	if self.effect.node:
		self.node = self.effect.node.instance_scene()
		self.character_data.character.add_child(self.node)
	
func constructor(m_character_data : CharacterData, m_effect : Effect) -> EffectInstance:
	self.character_data = m_character_data
	self.effect = m_effect
	return self
