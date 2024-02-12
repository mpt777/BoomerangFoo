extends Character
class_name Enemy

@onready
var n_hand := $Hand

@onready
var n_movement := $Movement

@onready
var n_nav := $NavigationAgent3D

var target_player : CharacterBody3D = null
var target_direction : Vector3 = Vector3.ZERO

var ai : AI
var rotation_speed := 10
var enemy_data : EnemyData
#var target_location : Vector3 = Vector3.ZERO

func constructor(enemy_data : EnemyData):
	self.enemy_data = enemy_data
	$HealthComponent.max_health = enemy_data.max_health
	
func _ready():
	super._ready()
	ai = AI.new().constructor(self)
	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Character")
	move_hand(delta)
	
func move_hand(delta):
	if target_player:
		n_hand.target_position = target_player.global_position
		if target_player.global_position != Vector3.ZERO && abs(target_player.global_position.x) > 0.99:
			#look_at(target_player.global_position)
			var new_transform = transform.looking_at(target_player.global_position, Vector3.UP)
			transform = transform.interpolate_with(new_transform, rotation_speed * delta)
		rotation.x = 0
		
func attack():
	pass
	
func current_movement_state() -> String:
	return $MovementFSM.current_state_name()
	
