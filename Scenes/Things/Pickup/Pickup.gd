extends Area3D
class_name Pickup

var SPELLS = {
	"fire": FireSpell
}

func random_spell() -> Spell:
	return SPELLS[SPELLS.keys()[randi() % SPELLS.size()]].new()

func pickup(character : Character) -> void:
	character.signals.emit_signal("Mana.AddMana", random_spell())
	queue_free()
