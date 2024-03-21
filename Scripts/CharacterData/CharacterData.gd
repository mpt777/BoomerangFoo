extends Resource
class_name CharacterData

var character_name : String
var max_health := 1
var color : Color = Color(randf(),randf(),randf(),1)

var melee_spell : Spell = RockWallSpell.new()
var range_spell : Spell

var ice_projectile = preload("res://Scenes/Things/Spells/IceSpell/Projectile/IceProjectile.tscn")


func instantiate_scene() -> Character:
	return 

func _init():
	self.max_health = GameState.settings.character_max_health
	var range_spell := ResourceSpell.new()
	range_spell.spell_cast = SpellCast.new()
	range_spell.spell_projectile = ice_projectile
	self.range_spell = range_spell
