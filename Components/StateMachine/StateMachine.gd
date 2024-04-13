extends Node
class_name StateMachine

@export var initial_state : State = null

var current_state : State = null
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_on_child_transitioned)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		
func _on_child_transitioned(state, new_state_name: String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = new_state
	new_state.enter()
	
func current_state_name() -> String:
	return current_state.name.to_lower()
