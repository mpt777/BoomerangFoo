extends Node
class_name ManaComponent

@export 
var max_mana := 1.0
var mana := 1.0

func _ready():
	mana = max_mana

func is_able_to_cast(spell : SpellCast) -> bool:
	return mana >= spell.cost
	
func cast(spell : SpellCast) -> void:
	mana -= spell.cost
	
func add_mana(spell : SpellCast) -> void:
	mana = min(mana + spell.cost, max_mana)
