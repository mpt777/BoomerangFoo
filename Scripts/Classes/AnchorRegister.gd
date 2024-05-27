extends Node
class_name AnchorRegister

var anchors : Dictionary

func register(anchor: Anchor) -> void:
	anchors[code].add(node_3d)
	
func anchor(code : String) -> Array[Node3D]:
	return anchors[code]
	

