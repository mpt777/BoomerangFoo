extends Weapon
class_name Wand

@export 
var mana_component : ManaComponent

var range_spell : Spell
var melee_spell : Spell

var current_spell : Spell
var spell_lookup := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	range_spell = FireSpell.new()
	melee_spell = RockWallSpell.new()
	
	spell_lookup = {
		"range": range_spell,
		"melee": melee_spell
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func use(type : String):
	current_spell = spell_lookup[type]
	if mana_component.is_able_to_cast(current_spell):
		if ($StateMachine.current_state.has_method("attack")):
			$StateMachine.current_state.attack()
		
func _on_attack_attacked():
	mana_component.cast(current_spell)
