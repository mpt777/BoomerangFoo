extends Spell
class_name ResourceSpell

var spell_cast : SpellCast
var spell_projectile : SpellProjectile
	
func constructor() -> Spell:
	return self
	
func projectile() -> Projectile:
	return self.spell_projectile.projectile()
	
func attack(weapon : Weapon) -> Attack:
	var a := Attack.new()
	a.damage = 1
	a.character = weapon.weapon_owner.data
	return a
	
func cast(weapon: Weapon) -> void:
	self.spell_cast.process(self, weapon)
	
func apply_resource(spell_resource : SpellResource) -> void:
	if spell_resource is SpellCast:
		self.spell_cast = spell_resource
	if spell_resource is SpellProjectile:
		self.spell_projectile = spell_resource
		
func spell_type():
	return spell_projectile.spell_type
