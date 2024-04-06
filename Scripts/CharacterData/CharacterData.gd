extends Resource
class_name CharacterData

var character_name : String
var max_health := 1
var color : Color = Color(randf(),randf(),randf(),1)

var melee_spell : ResourceSpell
var range_spell : ResourceSpell

func instantiate_scene() -> Character:
	return 

func _init():
	self.max_health = GameState.settings.character_max_health
	var range_spell := ResourceSpell.new()
	range_spell.spell_cast = SpellCast.new()
	range_spell.spell_projectile = SpellProjectile.new()
	range_spell.spell_projectile.PROJECTILE = range_spell.spell_projectile.DEFAULT_PROJECTILE
	
	var melee_spell := ResourceSpell.new()
	melee_spell.spell_cast = SpellCast.new()
	melee_spell.spell_projectile = SpellProjectile.new()
	melee_spell.spell_projectile.PROJECTILE = melee_spell.spell_projectile.DEFAULT_MELEE_PROJECTILE
	
	self.range_spell = range_spell
	self.melee_spell = melee_spell
	print(self)
