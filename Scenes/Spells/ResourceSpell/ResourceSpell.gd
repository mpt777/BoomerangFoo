extends Spell
class_name ResourceSpell

#var spell_cast : SpellCast
var spell_projectile : SpellProjectile
var stats : StatManager
	
func constructor() -> Spell:
	return self
	
func projectile() -> Projectile:
	return self.spell_projectile.projectile()
	
func cast(weapon: Weapon) -> void:
	var tap_count : int = self.stats.get_value("p.tap_count", 1)
		
	for count in tap_count:
		self.spell_projectile.spell_cast.instance_projectiles(self, weapon)
		await Game.get_tree().create_timer(0.3).timeout
