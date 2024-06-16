extends Directive
class_name D_MeleeAttack

var MIN_ATTACK_RANGE := 5
var MAX_ATTACK_RANGE := 1000
var velocities : Array[Vector3]


func decide(enemy : Enemy) -> int:
	if not GameState.settings.settings.get_value("enemy_attack", true):
		return 0
	if not enemy.target_player:
		return 0
	if enemy.n_mana.mana <= 0:
		return 0
	if enemy.n_wand.n_state.current_state.is_alias("Reloading"):
		return 0
	if enemy.enemy_projectiles():
		return 75
	#var dist := enemy.global_position.distance_squared_to(enemy.target_player.global_position)
	#if dist < MIN_ATTACK_RANGE or dist > MAX_ATTACK_RANGE:
		#return 0
	return 0
	
func apply(enemy : Enemy) -> void:
	var first = enemy.enemy_projectiles()[0]
	enemy.target_rot_pos = first.global_position
	
	#todo, see if projectile will hit with a raycast? If so, then block it
	enemy.signals.emit_signal("Attack.Start")
	enemy.signals.emit_signal("Attack.Attack", "melee")
	
func unapply() -> void:
	self.enemy.target_rot_pos = Vector3.ZERO



