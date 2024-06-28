extends Node
class_name Profile
# Achievements, avatars, cosmetics. Things that persist a session

var avatars : Array[AvatarData] = [
	preload("res://Scenes/Entities/Avatar/Witch/witch_data.tres"),
	preload("res://Scenes/Entities/Avatar/Robot/robot_data.tres")
]
var cosmetics : Array[CosmeticData] = [
	preload("res://Assets/Blender/Cosmetics/Sunglasses/Sunglasses.tres"),
	preload("res://Assets/Blender/Cosmetics/WitchHat/WitchHatData.tres")
]

var exp : int = 0
var level : int = 0
var _exp_per_level = 100

func exp_to_next_level() -> int:
	return self._exp_per_level - self.exp
	
func add_exp(delta: int) -> void:
	self.exp += delta
	if self.exp > self._exp_per_level:
		self.exp -= self._exp_per_level
		self.add_level(1)
		
func add_level(delta : int) -> void:
	self.level += 1
	self.unlock()
	
func unlock() -> void:
	print("Unlock Someting!")
