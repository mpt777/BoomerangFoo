extends Weapon
class_name Wand

@export 
var mana_component : ManaComponent

var range_spell : Spell
var melee_spell : Spell

var current_spell : Spell

var CHARACTER_MESSAGE = preload("res://Scenes/Enviroment/CharaterMessage/character_message_text.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():	
	weapon_owner.signals.register("Wand.ChangeSpell", change_spell)
	$"/root/Signals".connect("start_round", initialize)
	
func initialize():
	emit_message(range_spell.spell_projectile)
	emit_message(range_spell.spell_cast)
	emit_message(melee_spell.spell_projectile)

func emit_message(spell_resource : SpellResource):
	var message : CharacterMessageText = CHARACTER_MESSAGE.instantiate()
	message.constructor(spell_resource.name, spell_resource.color)
	weapon_owner.signals.emit_signal("Message.AddMessage", message)
	
func use(type : String):
	current_spell = spell_lookup(type)
	if mana_component.is_able_to_cast(current_spell):
		if ($StateMachine.current_state.has_method("attack")):
			$StateMachine.current_state.attack()
		
func _on_attack_attacked():
	mana_component.cast(current_spell)
	weapon_owner.signals.emit_signal("Wand.Reloading")
	
func _on_reloading_reloaded():
	weapon_owner.signals.emit_signal("Wand.Reloaded")
	
func spell_lookup(lookup_string : String) -> Spell:
	var lookup := {
		"range": range_spell,
		"melee": melee_spell
	}
	return lookup[lookup_string]
	
func change_spell(spell : Spell):
	if spell.spell_type() == spell.SPELL_TYPES.RANGE:
		range_spell = spell
		weapon_owner.data.range_spell = spell
	else:
		melee_spell = spell
		weapon_owner.data.melee_spell = spell
