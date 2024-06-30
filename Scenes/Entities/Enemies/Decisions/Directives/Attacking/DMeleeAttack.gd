extends Directive
class_name D_MeleeAttack

var MIN_ATTACK_RANGE := 5
var MAX_ATTACK_RANGE := 1000
var velocities : Array[Vector3]
var projectile : AttackComponent


func decide(enemy : Enemy) -> int:
	if not Game.settings.settings.get_value("enemy_attack", true):
		return 0
	if not enemy.target_player:
		return 0
	if enemy.n_mana.mana <= 0:
		return 0
	if enemy.n_wand.n_state.current_state.is_alias("Reloading"):
		return 0
	if self.will_be_hit():
		return 75
	return 0
	
#func will_be_hit() -> bool:
	## todo, might need a shapecast?
	#var space = enemy.get_world_3d().direct_space_state
	#for p in enemy.enemy_projectiles():
		#p = p as AttackComponent
		#var ray_query = PhysicsRayQueryParameters3D.new()
		#ray_query.from = p.global_position
		#ray_query.to = -p.global_transform.basis.z * 100
		#ray_query.collide_with_areas = true
		#ray_query.collide_with_bodies = false
		#ray_query.set_collision_mask(1 << 4 - 1)
		#var raycast_result = space.intersect_ray(ray_query)
		#if raycast_result.is_empty():
			#continue
		#var proj = raycast_result.get("collider")
		#if proj is HitboxComponent and enemy.n_hitbox == proj:
			#self.projectile = p
			#return true
	#return false
	
func will_be_hit() -> bool:
	var space = enemy.get_world_3d().direct_space_state
	for projectile in enemy.enemy_projectiles():
		projectile = projectile as AttackComponent
		var ray_query = PhysicsShapeQueryParameters3D.new()
		ray_query.collide_with_areas = true
		var shape = BoxShape3D.new()
		shape.size.z = 100
		ray_query.set_shape(shape)
		ray_query.transform = projectile.global_transform
		ray_query.set_collision_mask(1 << 4 - 1)
		var raycast_result = space.intersect_shape(ray_query)
		if raycast_result.is_empty():
			continue
		var result = raycast_result.filter(func(x): return x.get("collider") is HitboxComponent and x.get("collider") == enemy.n_hitbox)
		if result:
			self.projectile = projectile
			return true
	return false
	
func apply(enemy : Enemy) -> void:
	enemy.target_rot_pos = self.projectile.global_position
	
	# todo, have wand rotate independent of player rotation
	enemy.ai.aim()
	enemy.signals.emit_signal("Attack.Start")
	enemy.signals.emit_signal("Attack.Attack", "melee")
	
func unapply() -> void:
	self.enemy.target_rot_pos = Vector3.ZERO



