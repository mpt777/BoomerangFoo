extends Effect
class_name SpeedEffect

func apply(character : Character):
	character.data.modifiers.append(self)
	self.emit_message(character)
	
@export var ratio : float
