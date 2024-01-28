extends Area3D

@export
var body : CharacterBody3D

var projectiles_in_area : Dictionary = {}
var other_projectiles_in_area : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func process_dodge():
	var best_direction = Vector3.ZERO


func _on_area_entered(area):
	if area is Projectile:
		if area.weapon_owner != body:
			other_projectiles_in_area[area.get_instance_id()] = area

func _on_area_exited(area):
	if area is Projectile:
		if area.weapon_owner != body:
			other_projectiles_in_area.erase(area.get_instance_id())
