extends Weapon
class_name Wand

@export var mana_component : ManaComponent

var current_spell : Spell

# Called when the node enters the scene tree for the first time.
func _ready():	
	#weapon_owner.signals.register("Wand.ChangeSpell", change_spell)
	weapon_owner.signals.register("Wand.Attack", use)
	
func _physics_process(delta):
	return
	global_transform = weapon_owner.anchors.anchor("RightHand").global_transform
	#global_rotation = weapon_owner.anchors.anchor("RightHand").global_rotation
	
func use(type : String):
	current_spell = create_spell(type)
	if mana_component.is_able_to_cast(current_spell):
		if ($StateMachine.current_state.has_method("attack")):
			$StateMachine.current_state.attack()
			
func attack() -> void:
	current_spell.cast(self)
	mana_component.cast(current_spell)
	weapon_owner.signals.emit_signal("Wand.Reloading")
	
func _on_reloading_reloaded():
	weapon_owner.signals.emit_signal("Wand.Reloaded")
	
func create_spell(lookup_string : String) -> Spell:
	var spell := ResourceSpell.new()
	spell.modifiers = weapon_owner.data.modifiers.filter(func(x):return x is SpellModifier)
	spell.spell_projectile = weapon_owner.data.melee_projectile  if lookup_string == "melee" else weapon_owner.data.range_projectile
	return spell
