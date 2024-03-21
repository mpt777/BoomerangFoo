extends Area3D
class_name Pickup

var PROJECTILES = [
	preload("res://Scenes/Things/Spells/FireSpell/Projectile/FireProjectile.tscn"),
	preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")
]
#
#func random_spell() -> Spell:
	#return SPELLS[randi() % SPELLS.size()].new()
#
#func pickup(character : Character) -> void:
	#character.signals.emit_signal("Wand.ChangeSpell", random_spell())
	#
	#var spell := Spell.new()
	#spell.cost = 3
	#character.signals.emit_signal("Mana.AddMana", spell)
	#
	#queue_free()
	
func random_projectile() -> PackedScene:
	return PROJECTILES[randi() % PROJECTILES.size()]
	
func pickup(character : Character) -> void:
	var new_spell : ResourceSpell = character.range_spell()
	
	if randi() % 2:
		new_spell.spell_cast.count = (randi() % 3) + 1
	else:
		new_spell.spell_projectile = random_projectile()
	character.signals.emit_signal("Wand.ChangeSpell", new_spell)
	
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	
	queue_free()
