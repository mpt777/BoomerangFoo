extends StandardCharacter
class_name Enemy

@onready
var n_movement := $Movement

@onready
var n_nav := $NavigationAgent3D

var target_player : CharacterBody3D = null
var target_direction : Vector3 = Vector3.ZERO

var ai : AI
var rotation_speed := 10
#var target_location : Vector3 = Vector3.ZERO

func constructor(enemy_data : EnemyData):
	self.data = enemy_data
	$HealthComponent.max_health = self.data.stats.get_value("max_health")
	
	#$MeshInstance3D.mesh.material = StandardMaterial3D.new()
	#$MeshInstance3D.mesh.material.albedo_color = enemy_data.color
	
func _ready():
	super._ready()
	ai = AI.new().constructor(self)
	$AvatarWrapper.constructor(self)
	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Character")
	move_hand(delta)
	
func move_hand(delta):
	if target_player:
		if target_player.global_position != Vector3.ZERO && abs(target_player.global_position.x) > 0.99:
			#look_at(target_player.global_position)
			var new_transform = transform.looking_at(target_player.global_position, Vector3.UP)
			transform = transform.interpolate_with(new_transform, rotation_speed * delta)
		rotation.x = 0
	
func current_movement_state() -> String:
	return $MovementFSM.current_state_name()
	
func get_input_direction() -> Vector3:
	return self.target_direction
	
