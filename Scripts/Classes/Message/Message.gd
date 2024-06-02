extends Resource
class_name Message

var CHARACTER_MESSAGE = preload("res://Scenes/Entities/CharacterMessage/CharacterMessageText.tscn")

@export var name : String
@export var color : Color
	
func emit_message(character : Character):
	var message : CharacterMessageText = CHARACTER_MESSAGE.instantiate()
	message.constructor(self.name, self.color)
	character.signals.emit_signal("Message.AddMessage", message)
