extends PanelContainer
class_name CharacterCircle

@onready
var avatar_container = $HBoxContainer/SubViewportContainer/SubViewport/AvatarContainer

@onready
var viewport_container = $HBoxContainer/SubViewportContainer
var character_data : CharacterData
var cosmetic_selectors = {}
var avatar : Avatar

class CosmeticSelector:
	var alias : Enums.AnchorAlias
	var avatar : Avatar
	var valid_cosmetics # Array[CosmeticData]
	var index : int
	func constructor(alias: Enums.AnchorAlias, avatar: Avatar) -> CosmeticSelector:
		self.alias = alias
		self.avatar = avatar
		self.valid_cosmetics = [null]
		
		self.index = 0
		var default_cosmetics = avatar.default_cosmetics.filter(func(x): return x.alias == self.alias)
		self.valid_cosmetics.append_array(default_cosmetics)
		if default_cosmetics:
			self.index = Utils.find_item(self.valid_cosmetics, default_cosmetics[0])
			
		self.valid_cosmetics.append_array(GameProfile.cosmetics.filter(func(x): return x.alias == self.alias))
	
		self.valid_cosmetics = Utils.array_unique(self.valid_cosmetics)

		return self
		
	func increment(direction: int):
		self.index = (self.index + direction) % len(self.valid_cosmetics)
		
	func current_cosmetic() -> CosmeticData:
		return self.valid_cosmetics[self.index]
		
	func apply() -> void:
		var c = self.current_cosmetic()
		if c:
			self.avatar.change_cosmetic(c)
		else:
			self.avatar.remove_cosmetic(self.alias)

func constructor(p_character_data : CharacterData):
	self.character_data = p_character_data
	
func set_color(color : Color) -> void:
	viewport_container.material.set_shader_parameter("color", color)
	
func set_avatar(p_avatar_data : AvatarData):
	self.character_data.avatar = p_avatar_data
	for child in avatar_container.get_children():
		child.queue_free()
	self.avatar = self.character_data.avatar.avatar.instantiate()
	avatar_container.add_child(self.avatar)
	$"/root/Signals".emit_signal("avatar_attached_to_character", self.character_data)
	for e in Enums.AnchorAlias.values():
		self.cosmetic_selectors[e] = CosmeticSelector.new().constructor(e, avatar)
	#self.set_color(self.character_data.avatar.color)
	
func cycle_cosmetic(controller: Controller, alias : Enums.AnchorAlias, direction: int) -> void:
	if not self.cosmetic_selectors.get(alias, null):
		return
	self.cosmetic_selectors[alias].increment(direction)
	self.cosmetic_selectors[alias].apply()
	self.set_character_cosmetics()
	
func set_character_cosmetics():
	self.character_data.cosmetics = []
	for cs in self.cosmetic_selectors.values():
		var cosmetic = cs.current_cosmetic()
		if cosmetic:
			self.character_data.cosmetics.append(cosmetic)
