extends Area3D
class_name Pickup

var SPELLS = [
	FireSpell,
	RockWallSpell,
	IceSpell,
]

func random_spell() -> Spell:
	return SPELLS[randi() % SPELLS.size()].new()

func pickup(character : Character) -> void:
	character.signals.emit_signal("Wand.ChangeSpell", random_spell())
	
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	
	queue_free()
