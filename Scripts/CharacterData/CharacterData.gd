extends Resource
class_name CharacterData

var character_name : String
var max_health := 1
var color : Color = Color(randf(),randf(),randf(),1)

var melee_spell : Spell = RockWallSpell.new()
var range_spell : Spell


func instantiate_scene() -> Character:
	return 

func _init():
	self.max_health = GameState.settings.character_max_health
	var range_spell := ResourceSpell.new()
	range_spell.spell_cast = SpellCast.new()
	range_spell.spell_projectile = SpellProjectile.new()
	self.range_spell = range_spell
