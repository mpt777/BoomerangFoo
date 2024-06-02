extends Resource
class_name NodeModifier

@export var node : PackedScene

func instance_scene():
	return node.instantiate()
