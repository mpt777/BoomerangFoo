extends StandardCharacter
class_name Enemy

@onready var n_movement := $AvoidanceMovement
@onready var n_nav := $NavigationAgent3D
@onready var n_avoidance : EtArea = $ProximityArea
@onready var n_projectiles : EtArea = $Projectiles

var target_player : StandardCharacter = null
var target_direction : Vector3 = Vector3.ZERO
var target_rot_pos : Vector3 = Vector3.ZERO

@export var ai : AI
var ai_map : AIMap
var rotation_speed := 0.2
#var target_location : Vector3 = Vector3.ZERO

@export var _tick_counter := 0.2
@export var tick_timer := 0.2
var on_tick := true

func constructor(enemy_data : EnemyData):
	self.data = enemy_data
	self.data.set_character(self)
	$HealthComponent.max_health = self.data.stats.get_value("max_health")
	
func _ready():
	super._ready()
	ai = ai.duplicate(true).constructor(self)
	ai_map = AIMap.new().constructor(self)
	$AvatarWrapper.constructor(self)
	
func _physics_process(delta : float) -> void:
	super(delta)
	self._tick(delta)
	if self.on_tick:
		tick()

	self.ai_map.update_target_direction()
	
	move_hand(delta)
	
	
func tick():
	self.target_player = Utils.closest_node_in_group(global_position, "Character")
	
func _tick(delta):
	self.on_tick = false
	self._tick_counter += delta
	if self._tick_counter > self.tick_timer:
		self._tick_counter -= self.tick_timer
		self.on_tick = true
	
func move_hand(delta):
	if target_player:
		self.ai.aim()
		#self.aim_at(target_player.global_position)
		
func enemy_projectiles() -> Array:
	var x = self.n_projectiles.areas.filter(func(x): return x is AttackComponent)
	var z = x.filter(func(x): return x.attack.character != self.data)
	return z
	
func current_movement_state() -> String:
	return $MovementFSM.current_state_name()
	
func get_input_direction() -> Vector3:
	return self.target_direction

