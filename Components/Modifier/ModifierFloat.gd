extends MessageModifier
class_name ModifierFloat

@export var value : float

func add(stat : Stat):
	stat.value = stat.get_value() + self.value
	
func remove(stat : Stat):
	stat.value = stat.get_value() - self.value
