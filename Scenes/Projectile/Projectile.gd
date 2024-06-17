extends Area3D
class_name Projectile

#var direction: Vector3 = Vector3.ZERO
@export var data : ProjectileData
@onready var n_attack : AttackComponent = $AttackComponent
var character_data : CharacterData
var omit : Array[Node3D]

func _ready() -> void:
	self.construct_attack()
	
func constructor(m_data : ProjectileData) -> Projectile:
	self.data = m_data
	return self
	
func construct_attack() -> void:
	self.omit = [self.character_data.character.n_hitbox]
	n_attack.set_attack(self.character_data)
	n_attack.attack.damage = self.data.DAMAGE
	
func set_character_data(character_data : CharacterData) -> void:
	self.character_data = character_data

func _physics_process(delta):
	position += -transform.basis.z * self.data.SPEED * delta
	
#func direction() -> Vector3:
	#return rotation
	
func delete() -> void:
	queue_free()
	



func _on_attack_component_area_entered(area: Area3D) -> void:
	if area in self.omit:
		return
	delete()

func _on_attack_component_body_entered(body: Node3D) -> void:
	if body in self.omit:
		return
	delete()
