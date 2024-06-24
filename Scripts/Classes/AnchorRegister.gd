extends Resource
class_name AnchorRegister

var anchors : Dictionary

func register(anchor: Anchor) -> void:
	anchors[anchor.alias] = anchor
	
func anchor(code : Enums.AnchorAlias) -> Anchor:
	return anchors.get(code, null)
	
func add(code : Enums.AnchorAlias, m_node : Node) -> void:
	var m_anchor := self.anchor(code)
	if not m_anchor:
		return
	m_anchor.add(m_node)
	
	

