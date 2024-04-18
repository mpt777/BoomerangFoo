extends Area3D
class_name Pickup

var CHARACTER_MESSAGE = preload("res://Scenes/Enviroment/CharaterMessage/CharacterMessageText.tscn")

var SPELL_RESOURCES = [
	preload("res://Scenes/Things/Spells/ResourceSpell/SpellProjectiles/FireProjectile.tres"),
	preload("res://Scenes/Things/Spells/ResourceSpell/SpellProjectiles/IceProjectile.tres"),
	preload("res://Scenes/Things/Spells/ResourceSpell/SpellProjectiles/RockWallProjectile.tres"),
	preload("res://Scenes/Things/Spells/ResourceSpell/SpellCasts/MultiSpell.tres"),
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
	
func random_resource() -> SpellResource:
	return SPELL_RESOURCES[randi() % SPELL_RESOURCES.size()]
	
func pickup(character : Character) -> void:
	var new_resource : SpellResource = random_resource()
	
	var range_spell : ResourceSpell = character.range_spell()
	var melee_spell : ResourceSpell = character.melee_spell()
	
	if new_resource is SpellProjectile:
		if new_resource.spell_type == new_resource.SPELL_TYPES.RANGE:
			range_spell.apply_resource(new_resource)
		else:
			melee_spell.apply_resource(new_resource)
	else:
		range_spell.apply_resource(new_resource)
		melee_spell.apply_resource(new_resource)
	
	character.signals.emit_signal("Wand.ChangeSpell", range_spell)
	character.signals.emit_signal("Wand.ChangeSpell", melee_spell)
	
	emit_message(character, new_resource)
	refill_mana(character)
	queue_free()
	
func emit_message(character : Character, new_resource : SpellResource):
	var message : CharacterMessageText = CHARACTER_MESSAGE.instantiate()
	message.constructor(new_resource.name, new_resource.color)
	character.signals.emit_signal("Message.AddMessage", message)

func refill_mana(character : Character):
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	
