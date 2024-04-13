extends Node
class_name ManaComponent

@export var character : Character
@export var max_mana := 1.0

var mana := 1.0

signal ManaChanged

func _ready():
	character.signals.register("Mana.AddMana", add_mana)
	mana = max_mana

func is_able_to_cast(spell : Spell) -> bool:
	return mana >= spell.cost
	
func cast(spell : Spell) -> void:
	mana -= spell.cost
	character.signals.emit_signal("Mana.ChangeMana", mana)
	ManaChanged.emit(mana)
	
func add_mana(spell : Spell) -> void:
	mana = min(mana + spell.cost, max_mana)
	character.signals.emit_signal("Mana.ChangeMana", mana)
