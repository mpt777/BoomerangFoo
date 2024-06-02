extends Resource
class_name PickupManager

var character_data : CharacterData
var _pickups : Array[EffectInstance]
var max_pickups := 3

var melee : EffectInstance
var range : EffectInstance

func add(effect : Effect) -> void:
	var efi = EffectInstance.new().constructor(self.character_data, effect)
	efi.apply()
	if effect.modifier is SpellProjectile:
		if "range" in effect.modifier.stat:
			self.range = efi
			return
		elif "melee" in effect.modifier.stat:
			self.melee = efi
			return
		
	self._pickups.append(efi)
	while len(self._pickups) > self.max_pickups:
		self.remove(self._pickups[0])
	
func remove(efi : EffectInstance) -> void:
	efi.remove()
	self._pickups.remove_at(0)
	
func initialize() -> void:
	self.emit_messages()
	self.add_nodes()
	
func add_nodes() -> void:
	for efi in self._pickups:
		efi.add_node()
		
func emit_messages() -> void:
	if not self.character_data.character:
		return
	for efi in self.all_pickups():
		efi.effect.message.emit_message(self.character_data.character)
	
func constructor(m_character_data : CharacterData, m_max_pickups : int = 3) -> PickupManager:
	self.character_data = m_character_data
	self.max_pickups = m_max_pickups
	return self
	
func all_pickups() -> Array[EffectInstance]:
	var _p = self._pickups.duplicate()
	_p.append_array([self.melee, self.range])
	return _p
	
func all_effects(): # -> Array[Effect]
	return self.all_pickups().map(func(x): return x.effect) as Array[Effect]
	
