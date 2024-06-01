extends Modifier
class_name ModifierProjectile

@export var value : SpellProjectile

func add(stat : Stat):
	stat.value = value
	
func remove(stat : Stat):
	pass
