extends Pickup
class_name ManaPickup

func pickup(character : Character) -> void:
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	queue_free()
