extends Weapon

@export 
var mana_component : ManaComponent

var FireProjectile = preload("res://Scenes/Projectile/FireProjectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spell() -> SpellCast:
	var spell = SpellCast.new()
	return spell

func attack():
	if mana_component.is_able_to_cast(spell()):
		if ($StateMachine.current_state.has_method("attack")):
			$StateMachine.current_state.attack()
		
func _on_attack_attacked():
	mana_component.cast(spell())
