extends Resource
class_name AI

var character : Enemy
const distance_bounds = Vector2(10, 30)
@export var movement_layer : DirectiveLayer
@export var attack_layer : DirectiveLayer

var aim_type := AimType.new()


func constructor(p_character) -> AI:
	self.character = p_character
	self.movement_layer = self.movement_layer.duplicate(true).constructor(self.character)
	self.attack_layer = self.attack_layer.duplicate(true).constructor(self.character)
	return self
	
func set_new_position(desired_position: Vector3) -> void:
	self.character.n_nav.target_location = desired_position
	
func aim() -> void:
	var enemy = self.character
	var target = enemy.target_rot_pos
	if enemy.target_rot_pos == Vector3.ZERO:
		target = enemy.target_player.global_position
	var speed = enemy.data.pickups.range.effect.modifier.projectile_data.SPEED
	var dist = enemy.global_position.distance_to(target)
	var pos = target+ (enemy.target_player.velocity * (dist / speed))

	pos = pos.lerp(target, self.aim_type.leading_weight)
	
	if target.distance_squared_to(pos) > self.aim_type.max_lead:
		pos = target
	
	if pos != Vector3.ZERO && abs(pos.x) > 0.99:
		var new_transform = enemy.transform.looking_at(pos, Vector3.UP)
		enemy.transform = enemy.transform.interpolate_with(new_transform,  self.aim_type.rotation_speed)
	enemy.rotation.x = 0
