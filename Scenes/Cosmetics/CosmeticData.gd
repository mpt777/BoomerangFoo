extends Resource
class_name CosmeticData

@export var cosmetic : PackedScene
@export var alias : Enums.AnchorAlias


func instance_scene() -> Node3D:
	return self.cosmetic.instantiate()
