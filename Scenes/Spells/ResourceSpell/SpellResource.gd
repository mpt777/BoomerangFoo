extends Effect
class_name SpellResource

func apply(character : Character):
	character.data.modifiers.append(self)
	self.emit_message(character)
	
func process(_spell : Spell, _weapon : Weapon):
	pass
