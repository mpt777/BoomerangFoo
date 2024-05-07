extends Node3D
class_name Ammo

var AMMO_ITEM = preload("res://Scenes/Things/Ammo/AmmoItem.tscn")

var READY_TRES = preload("res://Scenes/Things/Ammo/ammo_item_ready.tres")
var RELOAD_TRES = preload("res://Scenes/Things/Ammo/ammo_item_reload.tres")

var current_tres : Resource

@export var ammo : int = 3
@export var rotation_speed : float = -4.0
@export var radius : float = 1.0
@export var character : Character

var current_rotation := 0.0
var pi2 := 2 * PI

func _ready():
	character.signals.register("Mana.ChangeMana", set_ammo)
	character.signals.register("Wand.Reloading", set_reload)
	character.signals.register("Wand.Reloaded", set_ready)
	self.current_tres = READY_TRES
	self.set_ammo(ammo)
	
func _update_initial_locations():
	var initial := PI * 2 / self.ammo
	
	var index := 0
	for child in get_children():
		child.update_initial_rotation(initial * index)
		index += 1

func set_ammo(ammo : int) -> void:
	self.ammo = ammo
	
	var child_count := self.get_child_count()
	
	if self.ammo > child_count:
		var to_add := self.ammo - child_count 
		for i in range(to_add):
			var ammo_item = AMMO_ITEM.instantiate() as AmmoItem
			ammo_item.set_mesh_position(self.radius)
			ammo_item.set_mesh_material(self.current_tres)
			add_child(ammo_item)
	elif self.ammo < child_count:
		var index := 1
		for child in self.get_children():
			if self.ammo < index:
				child.queue_free()
			index += 1
			
	await get_tree().process_frame
	
	self._update_initial_locations()
	
func set_reload() -> void:
	self.current_tres = RELOAD_TRES
	self.update_tres()
	
func set_ready() -> void:
	self.current_tres = READY_TRES
	self.update_tres()
	
func update_tres() -> void:
	for child in self.get_children():
		child.set_mesh_material(self.current_tres)
	
func _physics_process(delta):
	self.current_rotation = self.wrap_rotation(self.current_rotation + delta * self.rotation_speed)
	self.set_rotation_y(self.current_rotation)
	
func wrap_rotation(p_rotation: float) -> float:
	if p_rotation > pi2:
		p_rotation -= pi2
	if p_rotation < 0:
		p_rotation += pi2
	return p_rotation
	
func set_rotation_y(p_rotation: float) -> void:
	global_rotation.y = p_rotation
	global_rotation.y = self.wrap_rotation(global_rotation.y)
	global_rotation.x = 0
	global_rotation.z = 0


func _on_mana_component_mana_changed(amount: int):
	self.set_ammo(amount)
