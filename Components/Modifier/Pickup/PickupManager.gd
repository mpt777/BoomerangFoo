extends Resource
class_name PickupManager

var charater_data : CharacterData
var _pickups : Array[MessageModifier]
var max_pickups := 3

var melee : MessageModifier
var range : MessageModifier

func add(modifier : MessageModifier) -> void:
	self._apply(modifier)
	if modifier is SpellProjectile:
		if "range" in modifier.stat:
			self.range = modifier
			return
		elif "melee" in modifier.stat:
			self.melee = modifier
			return
		
	self._pickups.append(modifier)
	while len(self._pickups) > self.max_pickups:
		self.remove(self._pickups[0])
		
func _apply(modifer : MessageModifier) -> void:
	if self.charater_data.character:
		modifer.message.emit_message(self.charater_data.character)
	self.charater_data.stats.apply(modifer)
	
func remove(modifier : MessageModifier) -> void:
	for stat in self.charater_data.character.data.stats.stats:
		if modifier in stat.modifiers:
			stat.remove_modifier(modifier)
	self._pickups.remove_at(0)
		
func emit_messages() -> void:
	if not self.charater_data.character:
		return
	for modifier in self._pickups:
		modifier.message.emit_message(self.charater_data.character)
	self.melee.message.emit_message(self.charater_data.character)
	self.range.message.emit_message(self.charater_data.character)
	
func constructor(m_charater_data : CharacterData, m_max_pickups : int = 3) -> PickupManager:
	self.charater_data = m_charater_data
	self.max_pickups = m_max_pickups
	return self
	
func all_pickups() -> Array[MessageModifier]:
	var _p = self._pickups.duplicate()
	_p.append_array([self.melee, self.range])
	return _p
	
