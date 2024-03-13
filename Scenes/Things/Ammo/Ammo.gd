extends Node3D
class_name Ammo

var AMMO_ITEM = preload("res://Scenes/Things/Ammo/ammo_item.tscn")

@export
var ammo : int = 1

@export
var rotation_speed : float = 0.1

@export
var radius : float

@export
var character : Character

var current_rotation := 0.0
var pi2 := 2 * PI

func _ready():
    self._update_initial_locations()
    
func _update_initial_locations():
    var count := self.get_child_count()
    var initial := PI * 2 / count
    
    var index := 0
    for child in get_children():
        child.update_initial_rotation(initial * index)
        index += 1

func set_ammo(ammo : int) -> void:
    print("set")
    self.ammo = ammo
    
    var child_count := self.get_child_count()
    
    if self.ammo > child_count:
        var to_add := self.ammo - child_count 
        for i in range(to_add):
            add_child(AMMO_ITEM.instantiate())
    elif self.ammo < child_count:
        var index := 1
        for child in self.get_children():
            if self.ammo < index:
                child.queue_free()
            index += 1
            
    await get_tree().process_frame
    
    self._update_initial_locations()
    
func _physics_process(delta):
    self.current_rotation = self.wrap_rotation(self.current_rotation + delta)
    self.set_rotation_y(self.current_rotation)
    
func wrap_rotation(rotation: float) -> float:
    if rotation > pi2:
        rotation -= pi2
    return rotation
    
func set_rotation_y(rotation: float) -> void:
    global_rotation.y = rotation
    global_rotation.y = self.wrap_rotation(global_rotation.y)
    global_rotation.x = 0
    global_rotation.z = 0


func _on_mana_component_mana_changed(amount: int):
    self.set_ammo(amount)
