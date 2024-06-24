extends Resource
class_name CharacterData

var character_name : String
var color : Color = Color(randf(),randf(),randf(),1)
var avatar : AvatarData
var character : Character

var cosmetics : Array[CosmeticData] = [
	preload("res://Scenes/Cosmetics/Data/Sunglasses.tres")
]
var stats : StatManager = StatManager.new()
var pickups : PickupManager = PickupManager.new().constructor(self, 2)

var signals := SignalRegister.new()

func set_character(m_character : Character) -> void:
	self.character = m_character
	
func instantiate_scene() -> Character:
	return 

func _init():
	self.initialize_stats()
	
func initialize_stats():
	self.stats.register(Stat.new().constructor("speed", 1))
	self.stats.register(Stat.new().constructor("max_health", GameState.settings.character_max_health))
	self.stats.register(Stat.new().constructor("p.range", null))
	self.stats.register(Stat.new().constructor("p.melee", null))
	self.stats.register(Stat.new().constructor("p.tap_count", 1))
	self.stats.register(Stat.new().constructor("p.speed", 1))
	self.stats.register(Stat.new().constructor("p.count", 1))
	
	self.pickups.add(GameState.settings.character_default_range)
	self.pickups.add(GameState.settings.character_default_melee)
