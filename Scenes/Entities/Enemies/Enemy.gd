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
#var target_location : Vector3 = Vector3.ZERO

func _ready():
	ai = AI.new().constructor(self)
	
func _physics_process(delta):
	target_player = Utils.closest_node_in_group(global_position, "Player")
	move_hand()
	
func move_hand():

	if target_player:
		n_hand.target_position = target_player.global_position
		if target_player.global_position != Vector3.ZERO && abs(target_player.global_position.x) > 0.99:
			look_at(target_player.global_position)
		rotation.x = 0
		
func attack():
	pass
	
func current_movement_state() -> String:
	return $MovementFSM.current_state_name()
	
