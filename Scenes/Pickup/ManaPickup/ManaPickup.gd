extends Pickup
class_name ManaPickup

@onready var n_bottle = $bottle

func pickup(character : Character) -> void:
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	queue_free()
