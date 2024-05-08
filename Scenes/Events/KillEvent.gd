extends Event
class_name KillEvent

var killed_character : CharacterData
var killer_character : CharacterData

func constructor(p_killed_character : CharacterData, p_killer_character : CharacterData) -> KillEvent:
	self.killed_character = p_killed_character
	self.killer_character = p_killer_character
	return self
	
