extends Node
class_name AnchorRegister

var anchors = {}

func register(name : String, node_3d : Node3D) -> void:
	anchors[name] = node_3d
	
func anchor(name : String) -> Node3D:
	return anchors[name]
	

