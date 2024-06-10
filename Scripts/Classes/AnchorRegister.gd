extends Resource
class_name AnchorRegister

var anchors : Dictionary

func register(anchor: Anchor) -> void:
	anchors[anchor.alias]= anchor
	
func anchor(code : String) -> Anchor:
	return anchors[code]
	

