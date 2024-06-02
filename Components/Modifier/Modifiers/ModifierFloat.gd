extends Modifier
class_name ModifierFloat

@export var value : float

func add(stat : Stat):
	super(stat)
	stat.value = stat.get_value() + self.value
	
func remove(stat : Stat):
	stat.value = stat.get_value() - self.value
