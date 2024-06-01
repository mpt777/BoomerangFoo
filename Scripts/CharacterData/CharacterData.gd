extends Resource
class_name CharacterData

var character_name : String
var color : Color = Color(randf(),randf(),randf(),1)
var avatar : AvatarData

var modifiers : Array
var stats : StatManager = StatManager.new()

#var melee_spell : ResourceSpellA
#var range_spell : ResourceSpell

func instantiate_scene() -> Character:
	return 

func _init():
	self.initialize_stats()
	
func initialize_stats():
	self.stats.register(Stat.new().constructor("speed", 1))
	self.stats.register(Stat.new().constructor("max_health", GameState.settings.character_max_health))
	self.stats.register(Stat.new().constructor("p.range", GameState.settings.character_default_range))
	self.stats.register(Stat.new().constructor("p.melee", GameState.settings.character_default_melee))
	self.stats.register(Stat.new().constructor("p.tap_count", 1))
	self.stats.register(Stat.new().constructor("p.speed", 1))
	self.stats.register(Stat.new().constructor("p.count", 1))
