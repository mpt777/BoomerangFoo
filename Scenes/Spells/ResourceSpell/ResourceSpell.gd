extends Spell
class_name ResourceSpell

#var spell_cast : SpellCast
var spell_projectile : SpellProjectile
var modifiers : Array
	
func constructor() -> Spell:
	return self
	
func projectile() -> Projectile:
	return self.spell_projectile.projectile()
	
func attack(weapon : Weapon) -> Attack:
	var a := Attack.new()
	a.damage = 1
	a.character = weapon.weapon_owner.data
	return a
	
func spell_type():
	return spell_projectile.spell_type
	
func cast(weapon: Weapon) -> void:
	var tap_count := 1
	for modifier in self.modifiers:
		tap_count *= modifier.tap_count
		
	for count in tap_count:
		instance_projectiles(weapon)
		await GameState.get_tree().create_timer(0.3).timeout
	
func instance_projectiles(weapon : Weapon) -> void:
	var count = 1
	var bullet_speed = 1
	for modifier in self.modifiers:
		count *= modifier.count
		bullet_speed *= modifier.speed
	
	var spread_angle_degrees = 20
	var start_angle = -spread_angle_degrees / 2.0
	var angle_increment = spread_angle_degrees / (count - 1.0)

	
	for i in range(count):
		var bullet := projectile()
		
		bullet.position = weapon.spawn_node().global_position
		bullet.position.y = 1 
		bullet.rotation = weapon.spawn_node().global_rotation
		bullet.attack = attack(weapon)
		bullet.speed *= bullet_speed

		if count > 1:
			bullet.rotate_y(deg_to_rad(start_angle + i * angle_increment))

		weapon.get_node("/root/Signals").emit_signal("add_projectile", bullet)
		

