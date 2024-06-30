extends Pickup
class_name SpellPickup

func spell_resources() -> Array[Effect]:
	return Game.run.config.pickup_config.possible_pickups
	
func random_resource() -> Effect:
	return self.spell_resources()[randi() % self.spell_resources().size()]
	
func valid_resources(character : Character) -> Array[Effect]:
	var resources : Array[Effect] = []
	for resource in self.spell_resources():
		if not resource in character.data.pickups.all_effects():
			resources.append(resource)
	return resources
	
	
func pickup(character : Character) -> void:
	var new_resource : Effect = random_resource()
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
	
