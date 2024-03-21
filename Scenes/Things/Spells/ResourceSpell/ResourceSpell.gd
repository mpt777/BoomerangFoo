extends Spell
class_name ResourceSpell

var spell_cast : SpellCast
var spell_projectile : PackedScene

func constructor() -> Spell:
	return self
	
func projectile() -> Projectile:
	return self.spell_projectile.instantiate()
	
func attack(weapon : Weapon) -> Attack:
	var a := Attack.new()
	a.damage = 1
	a.character = weapon.weapon_owner.data
	return a
	
func cast(weapon: Weapon) -> void:
	self.spell_cast.process(self, weapon)
