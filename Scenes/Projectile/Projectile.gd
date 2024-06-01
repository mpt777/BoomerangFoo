extends Area3D

class_name Projectile

#var direction: Vector3 = Vector3.ZERO
@export var speed: float = 30.0
@onready var n_attack : AttackComponent = $AttackComponent
var character_data : CharacterData

func _ready() -> void:
	self.construct_attack()
	
func construct_attack() -> void:
	n_attack.set_attack(self.character_data)
	
func set_character_data(character_data : CharacterData) -> void:
	self.character_data = character_data

func _physics_process(delta):
	position += -transform.basis.z * speed * delta
	
#func direction() -> Vector3:
	#return rotation
	
func delete() -> void:
	queue_free()
	



func _on_attack_component_area_entered(area: Area3D) -> void:
	delete()

func _on_attack_component_body_entered(body: Node3D) -> void:
	delete()
