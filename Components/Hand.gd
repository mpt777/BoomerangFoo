extends Node3D

class_name HandComponent

@export
var target : CharacterBody3D

@export
var RADIUS := 2

var weapon : Weapon

var target_position : Vector3 = Vector3.ZERO:
	set(value):
		target_position = value
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pickup(get_child(0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	set_positon_around_target()
	set_weapon_target_position()
	
	
func set_weapon_target_position() -> void:
	if not self.weapon:
		return
	weapon.target_position = target_position
	weapon.target_position.y = position.y
	
func set_positon_around_target() -> void:
	var dir : Vector3 = (target_position - target.position).normalized()
	position = (dir * RADIUS)
	position.y = 0
	
func throw():
	return
	for child in get_children():
		if child is Weapon:
			self.weapon = null
			child.throw()
			
func pickup(node):
	if not node is Weapon:
		return
	self.weapon = node
	node.pickup()
	if node.get_parent():
		node.get_parent().remove_child(node)
	add_child(node)
	
