extends Pickup
class_name SpellPickup

var SPELL_RESOURCES = [
	preload("res://Scenes/Spells/ResourceSpell/Projectiles/FireProjectile.tres"),
	preload("res://Scenes/Spells/ResourceSpell/Projectiles/IceProjectile.tres"),
	preload("res://Scenes/Spells/ResourceSpell/Projectiles/RockWallProjectile.tres"),
	preload("res://Scenes/Spells/ResourceSpell/Modifiers/MultiSpell.tres"),
	#preload("res://Scenes/Things/Spells/ResourceSpell/Modifiers/SpeedySpells.tres"),
	preload("res://Scenes/Spells/ResourceSpell/Modifiers/DoubleSpell.tres"),
	preload("res://Scenes/Entities/Modifiers/Speed.tres"),
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
	
func random_resource() -> MessageModifier:
	return SPELL_RESOURCES[randi() % SPELL_RESOURCES.size()]
	
	
func valid_resources(character : Character) -> Array[MessageModifier]:
	var resources : Array[MessageModifier] = []
	for resource in SPELL_RESOURCES:
		if not resource in character.data.pickups.all_pickups():
			resources.append(resource)
	return resources
	
	
func pickup(character : Character) -> void:
	var new_resource : MessageModifier = random_resource()
	var resources = self.valid_resources(character)
	if resources:
		new_resource = resources[randi() % resources.size()]
	
	character.data.pickups.add(new_resource)
	#character.data.stats.apply(new_resource)
	#new_resource.apply(character)
	#new_resource.message.emit_message(character)
	refill_mana(character)
	queue_free()

func refill_mana(character : Character):
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	
