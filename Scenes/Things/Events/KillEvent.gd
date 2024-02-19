extends Event
class_name KillEvent

var killed_character : CharacterData
var killer_character : CharacterData

func constructor(killed_character : CharacterData, killer_character : CharacterData) -> KillEvent:
	self.killed_character = killed_character
	self.killer_character = killer_character
	return self
	
