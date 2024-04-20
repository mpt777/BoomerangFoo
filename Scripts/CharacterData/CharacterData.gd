extends Resource
class_name CharacterData

var character_name : String
var max_health := 1
var color : Color = Color(randf(),randf(),randf(),1)
var avatar : AvatarData

var effects := EffectRegister.new()

var melee_projectile : SpellProjectile
var range_projectile : SpellProjectile

var modifiers : Array

#var melee_spell : ResourceSpellA
#var range_spell : ResourceSpell

var RANGE = preload("res://Scenes/Things/Spells/ResourceSpell/SpellProjectiles/IceProjectile.tres")
var MELEE = preload("res://Scenes/Things/Spells/ResourceSpell/SpellProjectiles/RockWallProjectile.tres")

func instantiate_scene() -> Character:
	return 

func _init():
	self.max_health = GameState.settings.character_max_health
	self.range_projectile = RANGE
	self.melee_projectile = MELEE
