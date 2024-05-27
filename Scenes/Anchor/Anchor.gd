extends RemoteTransform3D
class_name Anchor

@export var alias : String
var nodes : Array[Node3D]

func add(node : Node3D) -> void:
	nodes.append(node)
	
#func get(node : Node3D) -> void:
	#nodes.append(node)
	
func remove(node : Node3D) -> void:
	nodes.remove_at(0)

func _physics_process(delta: float) -> void:
	for node in self.nodes:
		node.global_transform = self.global_transform


