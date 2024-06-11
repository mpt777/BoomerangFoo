extends Weapon
class_name Wand

@export var mana_component : ManaComponent
@onready var n_mesh = $Node3D
@onready var n_state : StateMachine = $StateMachine

var current_spell : Spell

# Called when the node enters the scene tree for the first time.
func _ready():	
	self.name = "Wand"
	weapon_owner.signals.register("Wand.Attack", use)
	
func use(type : String):
	var new_spell = create_spell(type)
	if mana_component.is_able_to_cast(new_spell):
		if ($StateMachine.current_state.has_method("attack")):
			current_spell = new_spell
			$StateMachine.current_state.attack()
			
func attack() -> void:
	current_spell.cast(self)
	mana_component.cast(current_spell)
	weapon_owner.signals.emit_signal("Wand.Reloading")
	
func _on_reloading_reloaded():
	weapon_owner.signals.emit_signal("Wand.Reloaded")
	
func create_spell(lookup_string : String) -> Spell:
	var spell := ResourceSpell.new()
	#spell.modifiers = weapon_owner.data.modifiers.filter(func(x):return x is SpellModifier)
	spell.stats = weapon_owner.data.stats
	spell.spell_projectile = weapon_owner.data.stats.get_value("p.melee") if lookup_string == "melee" else weapon_owner.data.stats.get_value("p.range")
	return spell
