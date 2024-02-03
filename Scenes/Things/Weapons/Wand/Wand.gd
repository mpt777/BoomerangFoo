extends Weapon
class_name Wand

@export 
var mana_component : ManaComponent

var range_spell : Spell
var melee_spell : Spell

# Called when the node enters the scene tree for the first time.
func _ready():
	range_spell = FireSpell.new()
	melee_spell = FireSpell.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack():
	if mana_component.is_able_to_cast(range_spell):
		if ($StateMachine.current_state.has_method("attack")):
			$StateMachine.current_state.attack()
		
func _on_attack_attacked():
	mana_component.cast(range_spell)
