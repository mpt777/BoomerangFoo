extends EtContainer


@onready var character_list = $MarginContainer/VBoxContainer/CharacterList

var containers := []

func _ready():
	character_list.initialize_players()


