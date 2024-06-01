extends Area3D
class_name Pickup

var SPELL_RESOURCES = [
	#preload("res://Scenes/Spells/ResourceSpell/Projectiles/FireProjectile.tres"),
	#preload("res://Scenes/Spells/ResourceSpell/Projectiles/IceProjectile.tres"),
	#preload("res://Scenes/Spells/ResourceSpell/Projectiles/RockWallProjectile.tres"),
	preload("res://Scenes/Spells/ResourceSpell/Modifiers/MultiSpell.tres"),
	#preload("res://Scenes/Things/Spells/ResourceSpell/Modifiers/SpeedySpells.tres"),
	#preload("res://Scenes/Spells/ResourceSpell/Modifiers/DoubleSpell.tres"),
	#preload("res://Scenes/Effects/Speed.tres"),
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
	
	
func valid_resources(character : Character) -> Array:
	var resources = []
	for resource in SPELL_RESOURCES:
		if resource == character.data.melee_projectile:
			continue
		if resource == character.data.range_projectile:
			continue
		if resource in character.data.modifiers:
			continue
		resources.append(resource)
	return resources
	
	
func pickup(character : Character) -> void:
	var new_resource : MessageModifier = random_resource()
	#var resources = self.valid_resources(character)
	#if resources:
		#new_resource = resources[randi() % resources.size()]
	
	character.data.stats.apply(new_resource.modifier)
	#new_resource.apply(character)
	new_resource.message.emit_message(character)
	refill_mana(character)
	queue_free()

func refill_mana(character : Character):
	var spell := Spell.new()
	spell.cost = 3
	character.signals.emit_signal("Mana.AddMana", spell)
	
