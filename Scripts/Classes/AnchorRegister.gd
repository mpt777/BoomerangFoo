extends Node
class_name AnchorRegister

var anchors = {}

func register(code : String, node_3d : Node3D) -> void:
	anchors[code] = node_3d
	
func anchor(code : String) -> Node3D:
	return anchors[code]
	

