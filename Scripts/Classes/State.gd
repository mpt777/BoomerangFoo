extends Node
class_name State

@export var alias : String
signal Transitioned

func is_alias(m_alias : String) -> bool:
	return alias.to_lower() == m_alias.to_lower()

func enter():
	pass
	
func exit():
	pass
	
func update(_delta : float):
	pass
	
func physics_update(_delta : float):
	pass

func _input(_event):
	pass
