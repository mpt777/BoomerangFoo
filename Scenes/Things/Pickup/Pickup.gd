extends Area3D
class_name Pickup


func pickup(character : Character):
	var spell := SpellCast.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	queue_free()
