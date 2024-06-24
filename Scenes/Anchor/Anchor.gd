extends RemoteTransform3D
class_name Anchor

@export var alias : Enums.AnchorAlias
var nodes : Array[Node3D]

func add(node : Node3D, as_child : bool = false) -> void:
	self.nodes.append(node)
	self._position_node(node)
	
#func get(node : Node3D) -> void:
	#nodes.append(node)
	
func remove(node : Node3D) -> void:
	nodes.remove_at(0)

func _physics_process(delta: float) -> void:
	self._position()
		
func _position() -> void:
	for node in self.nodes:
		self._position_node(node)
		
func _position_node(node : Node3D) -> void:
	node.global_transform = self.global_transform


