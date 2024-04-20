extends Resource
class_name Effect

var CHARACTER_MESSAGE = preload("res://Scenes/Enviroment/CharaterMessage/CharacterMessageText.tscn")

@export var name : String
@export var color : Color

func apply(character : Character):
	pass
	
func emit_message(character : Character):
	var message : CharacterMessageText = CHARACTER_MESSAGE.instantiate()
	message.constructor(self.name, self.color)
	character.signals.emit_signal("Message.AddMessage", message)
