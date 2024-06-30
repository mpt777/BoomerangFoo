extends Resource
class_name StatManager

@export var stats : Array[Stat]
var _stats : Dictionary

func _ready() -> void:
	for stat in self.stats:
		self.register(stat)
		
func constructor() -> StatManager:
	return self
		
func register(stat: Stat) -> void:
	self._stats[stat.title.to_lower()] = stat
	self.stats.append(stat)

func get_stat(stat_name : String) -> Stat:
	return self._stats[stat_name.to_lower()]
	
func get_value(stat_name : String, default=null):
	var stat : Stat = self._stats.get(stat_name.to_lower())
	if stat:
		return stat.get_value(default)
	return default
	
func apply(modifier: Modifier) -> void:
	var stat : Stat = self.get_stat(modifier.stat)
	if not stat: 
		return
	stat.add_modifier(modifier)
	

	