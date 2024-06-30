extends State
class_name AiBehaviorState

@export var body : Enemy
var can_attack := true

func _ready() -> void:
	body.signals.register("Wand.Reloaded", set_can_attack)
	
func set_can_attack() -> void:
	self.can_attack = true
	
func attack() -> void:
	if not Game.settings.settings.get_value("enemy_attack", true):
		return
	if not body.target_player:
		return
	if body.n_mana.mana <= 0:
		return
	if body.n_wand.n_state.current_state.is_alias("Reloading"):
		return
		
	body.signals.emit_signal("Attack.Start")
	
	await Game.get_tree().create_timer(0.3).timeout
	body.signals.emit_signal("Attack.Attack", "range")
	can_attack = false
		

